
/* 
Archive logging is a CDB-level setting, not a PDB-level setting. 
All PDBs share the root container's physical redo log files. 
Enabling it requires SYSDBA access at the root and a full CDB restart.
*/

-- Query to check current mode:
ARCHIVE LOG LIST;

-- Commands used to enable ARCHIVELOG on my local installation:
-- SHUTDOWN IMMEDIATE;
-- STARTUP MOUNT;
-- ALTER DATABASE ARCHIVELOG;
-- ALTER DATABASE OPEN;
