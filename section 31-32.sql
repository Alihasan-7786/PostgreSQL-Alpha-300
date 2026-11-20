-- SECTION 31: MANAGING DATABASE DESIGN WITH SCHEMA MIGRATIONS

-- 1. Renaming a column in the comments table (contents to body)
ALTER TABLE comments
RENAME COLUMN contents TO body;


-- 2. Changing the column name back to its original name
ALTER TABLE comments
RENAME COLUMN body TO contents;


-- 3. Creating an index on the user_id column in posts
CREATE INDEX IF NOT EXISTS posts_user_id_idx ON posts (user_id);

-- Removing the index to undo the change
DROP INDEX IF EXISTS posts_user_id_idx;


-- SECTION 32: SCHEMA VS DATA MIGRATIONS

-- 4. Creating the basic posts table (Lecture 242)
CREATE TABLE IF NOT EXISTS posts (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    lat REAL,
    lng REAL,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);


-- 5. Adding a new column called loc to the posts table (Lecture 245)
ALTER TABLE posts
ADD COLUMN loc VARCHAR(100);


-- 6. Filling the new loc column using the existing lat and lng values (Lectures 246, 248)
-- Updating only those rows where loc is empty and both coordinates are available
UPDATE posts
SET loc = CONCAT(lat, ',', lng)
WHERE loc IS NULL
  AND lat IS NOT NULL
  AND lng IS NOT NULL;


-- 7. Checking which database tables are locked during migrations (Lecture 247)
SELECT
    pid,
    mode,
    granted,
    relation::regclass AS locked_relation,
    query
FROM pg_locks l
JOIN pg_stat_activity a ON a.pid = l.pid
WHERE l.relation IS NOT NULL;


-- 8. Removing the old lat and lng columns after they are no longer needed (Lecture 251)
-- Run this only when the application is no longer using these columns
ALTER TABLE posts
DROP COLUMN IF EXISTS lat,
DROP COLUMN IF EXISTS lng;