-- 1. Your PDB exists and is open
SELECT name, open_mode FROM v$pdbs WHERE name = 'TUE_20251SEN222_JESSICA_CT_DB';

-- 2. Your admin user's default and temporary tablespaces
SELECT username, default_tablespace, temporary_tablespace 
FROM dba_users WHERE username = 'JESSICA_ADMIN';

-- 3. Each tablespace with its size, autoextend setting and maximum size
SELECT tablespace_name, file_name, bytes/1024/1024 AS size_mb, autoextensible, maxbytes/1024/1024 AS max_mb 
FROM dba_data_files WHERE tablespace_name LIKE 'CROPTRACE%';

-- 4. The archive log mode of the database
SELECT log_mode FROM v$database;
