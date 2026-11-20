-- 1. Checking the pg_class table (shown in pgAdmin during Lecture 185)
SELECT *
FROM pg_class;

-- 2. Getting the database OIDs and their names
SELECT oid, datname
FROM pg_database;

-- 3. Checking table OIDs, filenodes and their file paths
SELECT
    c.relname AS name,
    c.oid,
    c.relfilenode,
    pg_relation_filepath(c.oid) AS file_path
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public'
  AND c.relkind IN ('r', 'i', 'S')
ORDER BY c.oid;

-- 4. Checking the block size used by PostgreSQL (usually 8192 bytes or 8 KB)
SHOW block_size;

-- 5. Checking the ctid of rows in the users table
SELECT ctid, *
FROM users
LIMIT 10;