/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group 1
Project Name: CropTrace
*/

-- 1. Create the PDB
CREATE PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db
  ADMIN USER pdbadmin IDENTIFIED BY pdbadmin
  FILE_NAME_CONVERT = ('pdbseed', 'tue_20251sen222_jessica_ct_db');

-- 2. Open the PDB
ALTER PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db OPEN;

-- 3. Save state
ALTER PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db SAVE STATE;

-- 4. Switch into the new PDB
ALTER SESSION SET CONTAINER = tue_20251sen222_jessica_ct_db;

-- 5. Create your Admin User
CREATE USER jessica_admin IDENTIFIED BY jessica;
GRANT DBA TO jessica_admin;
