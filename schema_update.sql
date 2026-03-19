-- ============================================================
-- Certification Experience Map — Schema Update
-- Run this in: Supabase → SQL Editor → New query
-- Run AFTER schema.sql (the original schema must already exist)
-- ============================================================

-- 1. Track which cells have been manually edited via the UI
--    so the Excel importer knows to skip them during a merge
ALTER TABLE cells
  ADD COLUMN IF NOT EXISTS manually_edited  BOOLEAN     DEFAULT false,
  ADD COLUMN IF NOT EXISTS last_edited_at   TIMESTAMPTZ DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS last_edited_by   UUID        DEFAULT NULL;

-- 2. User profiles — links auth.users to a role
--    Role values: 'viewer' (default) | 'admin'
CREATE TABLE IF NOT EXISTS profiles (
  id          UUID        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  role        TEXT        NOT NULL DEFAULT 'viewer'
                          CHECK (role IN ('viewer','admin')),
  full_name   TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Auto-create a profile row whenever a new user signs up
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO profiles (id, full_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'full_name', NEW.email)
  )
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION handle_new_user();

-- 3. Row-level security for profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Any authenticated user can read profiles (needed for role checks)
CREATE POLICY "authenticated_read_profiles"
  ON profiles FOR SELECT
  USING (auth.role() = 'authenticated');

-- Users can update their own profile (except the role field)
CREATE POLICY "users_update_own_profile"
  ON profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id AND role = (SELECT role FROM profiles WHERE id = auth.uid()));

-- Admins can do everything
CREATE POLICY "admins_all_profiles"
  ON profiles FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- 4. Tighten the cells write policy to only allow admins
--    (drop the old catch-all authenticated write policy first)
DROP POLICY IF EXISTS "auth_write" ON cells;

CREATE POLICY "admins_write_cells"
  ON cells FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Apply the same admin-only write policy to all other tables
DROP POLICY IF EXISTS "auth_write" ON phases;
DROP POLICY IF EXISTS "auth_write" ON heat_dimensions;
DROP POLICY IF EXISTS "auth_write" ON heat_scores;
DROP POLICY IF EXISTS "auth_write" ON system_clusters;
DROP POLICY IF EXISTS "auth_write" ON systems;
DROP POLICY IF EXISTS "auth_write" ON system_phases;
DROP POLICY IF EXISTS "auth_write" ON enablers;

CREATE POLICY "admins_write_phases"          ON phases          FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_heat_dimensions" ON heat_dimensions FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_heat_scores"     ON heat_scores     FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_system_clusters" ON system_clusters FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_systems"         ON systems         FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_system_phases"   ON system_phases   FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));
CREATE POLICY "admins_write_enablers"        ON enablers        FOR ALL USING (EXISTS (SELECT 1 FROM profiles WHERE id = auth.uid() AND role = 'admin'));

-- ============================================================
-- HOW TO MAKE SOMEONE AN ADMIN
-- Run this in the SQL editor, replacing the email address:
--
--   UPDATE profiles
--   SET role = 'admin'
--   WHERE id = (
--     SELECT id FROM auth.users WHERE email = 'person@example.com'
--   );
--
-- ============================================================
