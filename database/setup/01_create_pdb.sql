-- 1. Create the pluggable database
CREATE PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db
  ADMIN USER pdbadmin IDENTIFIED BY pdbadmin
  FILE_NAME_CONVERT = ('pdbseed', 'tue_20251sen222_jessica_ct_db');

-- 2. Open the PDB
ALTER PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db OPEN;

-- 3. Save state so it opens automatically after a restart
ALTER PLUGGABLE DATABASE tue_20251sen222_jessica_ct_db SAVE STATE;
