-- ============================================================
-- Create Admin User Directly
-- Run this in: Supabase → SQL Editor → New query
-- This bypasses the UI and creates a user + profile directly
-- ============================================================

-- Step 1: Insert user into auth.users
-- Note: You'll need to generate a password hash. Use this SQL:
-- SELECT crypt('YourPasswordHere', gen_salt('bf'));

-- Example with password 'Admin123!' (pre-hashed)
-- Replace the password_hash with output from the crypt command above

-- First, let's create a simpler version that works:
-- This creates a user with email uxadmin@ul-experience-map.app

DO $$
DECLARE
  user_id uuid;
  hashed_password text;
BEGIN
  -- Generate password hash for 'Admin123!'
  hashed_password := crypt('Admin123!', gen_salt('bf'));
  
  -- Generate a new UUID for the user
  user_id := gen_random_uuid();
  
  -- Insert into auth.users
  INSERT INTO auth.users (
    id,
    instance_id,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    raw_app_meta_data,
    raw_user_meta_data,
    aud,
    role
  ) VALUES (
    user_id,
    '00000000-0000-0000-0000-000000000000',
    'uxadmin@ul-experience-map.app',
    hashed_password,
    NOW(),  -- Auto-confirm email
    NOW(),
    NOW(),
    '{"provider":"email","providers":["email"]}',
    '{"full_name":"UX Admin"}',
    'authenticated',
    'authenticated'
  );
  
  -- Insert into profiles (the trigger should do this, but let's be explicit)
  INSERT INTO profiles (id, role, full_name)
  VALUES (user_id, 'admin', 'UX Admin')
  ON CONFLICT (id) DO UPDATE SET role = 'admin';
  
  RAISE NOTICE 'User created successfully with ID: %', user_id;
  RAISE NOTICE 'Email: uxadmin@ul-experience-map.app';
  RAISE NOTICE 'Password: Admin123!';
  RAISE NOTICE 'Login username: uxadmin';
END $$;
