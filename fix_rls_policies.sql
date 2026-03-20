-- ============================================================
-- Fix RLS Policies - Fix 500 Error
-- Run this in: Supabase → SQL Editor → New query
-- The 500 error likely means the RLS policies are blocking the query
-- ============================================================

-- STEP 1: Drop all existing policies on profiles table
DROP POLICY IF EXISTS "authenticated_read_profiles" ON profiles;
DROP POLICY IF EXISTS "users_update_own_profile" ON profiles;
DROP POLICY IF EXISTS "admins_all_profiles" ON profiles;

-- STEP 2: Temporarily disable RLS on profiles for testing
ALTER TABLE profiles DISABLE ROW LEVEL SECURITY;

-- STEP 3: Verify profiles table is accessible
SELECT * FROM profiles;

-- STEP 4: Re-enable RLS with simpler, working policies
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Allow ALL authenticated users to read ALL profiles
CREATE POLICY "allow_authenticated_read_profiles"
  ON profiles FOR SELECT
  TO authenticated
  USING (true);

-- Allow users to update their own profile (but not change role)
CREATE POLICY "allow_users_update_own_profile"
  ON profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (
    auth.uid() = id 
    AND role = (SELECT role FROM profiles WHERE id = auth.uid())
  );

-- Allow admins to do everything on profiles
CREATE POLICY "allow_admins_all_profiles"
  ON profiles FOR ALL
  TO authenticated
  USING (
    (SELECT role FROM profiles WHERE id = auth.uid()) = 'admin'
  );

-- STEP 5: Verify policies are created
SELECT schemaname, tablename, policyname, permissive, roles, cmd
FROM pg_policies
WHERE tablename = 'profiles'
ORDER BY policyname;

-- STEP 6: Test the query that admin.html uses
SELECT role, full_name 
FROM profiles 
WHERE id = auth.uid();
