-- ============================================================
-- Fix Admin Access - COMPREHENSIVE DIAGNOSTIC AND REPAIR
-- Run this in: Supabase → SQL Editor → New query
-- ============================================================

-- STEP 1: Show ALL users in the system (to find the actual email)
SELECT 
  u.id,
  u.email,
  u.created_at,
  u.email_confirmed_at,
  p.id as profile_id,
  p.role,
  p.full_name
FROM auth.users u
LEFT JOIN profiles p ON u.id = p.id
ORDER BY u.created_at DESC;

-- STEP 2: Create profiles for ALL users who don't have one and make them admin
INSERT INTO profiles (id, role, full_name)
SELECT 
  u.id,
  'admin',
  COALESCE(u.raw_user_meta_data->>'full_name', u.email)
FROM auth.users u
WHERE NOT EXISTS (SELECT 1 FROM profiles WHERE id = u.id)
ON CONFLICT (id) DO NOTHING;

-- STEP 3: Make ALL existing users admin (for testing)
UPDATE profiles
SET role = 'admin'
WHERE role != 'admin';

-- STEP 4: Verify - show all users with their admin status
SELECT 
  u.email,
  p.role,
  p.full_name,
  u.id
FROM auth.users u
JOIN profiles p ON u.id = p.id
ORDER BY u.created_at DESC;

-- STEP 5: If still having issues, run this to check RLS policies
SELECT 
  schemaname, 
  tablename, 
  policyname, 
  permissive, 
  roles, 
  cmd,
  CASE 
    WHEN qual IS NOT NULL THEN 'Has USING clause'
    ELSE 'No USING clause'
  END as has_qual
FROM pg_policies
WHERE tablename = 'profiles'
ORDER BY policyname;
