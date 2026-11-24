/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group B
Project Name: CropTrace
*/

-- 1. Create Data Tablespace
CREATE TABLESPACE croptrace_data 
  DATAFILE 'croptrace_data01.dbf' SIZE 100M 
  AUTOEXTEND ON NEXT 10M MAXSIZE 1G;

-- 2. Create Index Tablespace
CREATE TABLESPACE croptrace_idx 
  DATAFILE 'croptrace_idx01.dbf' SIZE 50M 
  AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- 3. Create Temporary Tablespace
CREATE TEMPORARY TABLESPACE croptrace_temp 
  TEMPFILE 'croptrace_temp01.dbf' SIZE 50M 
  AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- 4. Assign tablespaces and quotas to the admin user
ALTER USER jessica_admin 
  DEFAULT TABLESPACE croptrace_data 
  TEMPORARY TABLESPACE croptrace_temp 
  QUOTA UNLIMITED ON croptrace_data 
  QUOTA UNLIMITED ON croptrace_idx;
