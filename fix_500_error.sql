-- ============================================================
-- SIMPLE FIX - Remove Recursive Policy Issue
-- Run this in: Supabase → SQL Editor → New query
-- This fixes the 500 error by removing policy recursion
-- ============================================================

-- Drop ALL existing policies on profiles
DROP POLICY IF EXISTS "authenticated_read_profiles" ON profiles;
DROP POLICY IF EXISTS "users_update_own_profile" ON profiles;
DROP POLICY IF EXISTS "admins_all_profiles" ON profiles;
DROP POLICY IF EXISTS "allow_authenticated_read_profiles" ON profiles;
DROP POLICY IF EXISTS "allow_users_update_own_profile" ON profiles;
DROP POLICY IF EXISTS "allow_admins_all_profiles" ON profiles;

-- Create simple, non-recursive policies
-- 1. Everyone can READ profiles (no recursion)
CREATE POLICY "public_read_profiles"
  ON profiles FOR SELECT
  USING (true);

-- 2. Users can UPDATE their own profile (no recursion)
CREATE POLICY "users_update_own"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- 3. Only allow INSERT/DELETE through service role (not from app)
CREATE POLICY "service_role_only"
  ON profiles FOR INSERT
  WITH CHECK (false);

CREATE POLICY "prevent_delete"
  ON profiles FOR DELETE
  USING (false);

-- DONE! Now test it
SELECT * FROM profiles;
