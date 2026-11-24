/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group B
Project Name: CropTrace
*/ 

-- 1. Switch to the new PDB
ALTER SESSION SET CONTAINER = tue_20251sen222_jessica_ct_db;

-- 2. Create the admin user with the specific password convention
CREATE USER jessica_admin IDENTIFIED BY jessica;

-- 3. Grant the DBA role to this user
GRANT DBA TO jessica_admin;
