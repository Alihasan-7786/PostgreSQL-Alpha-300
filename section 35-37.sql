-- SECTION 35: SECURITY AROUND POSTGRESQL (CRUD + PARAMETERIZED QUERIES)

-- 1. Using a parameterized query to safely get user details (Lectures 265–267)
SELECT id, username, bio
FROM users
WHERE username = $1;


-- 2. Adding a new user and getting the inserted details back (Lectures 268–269)
INSERT INTO users (username, bio)
VALUES ($1, $2)
RETURNING id, username, bio;


-- 3. Updating user details using their ID and getting the updated record (Lecture 270)
UPDATE users
SET username = $1,
    bio = $2
WHERE id = $3
RETURNING id, username, bio;


-- 4. Deleting a user using their ID and getting the deleted record back (Lecture 271)
DELETE FROM users
WHERE id = $1
RETURNING id, username, bio;


-- SECTION 36: FAST PARALLEL TESTING (SCHEMA ISOLATION)

-- 5. Creating a separate schema for a test worker and setting the search path (Lectures 279–282)
CREATE SCHEMA test_worker_1;
SET search_path TO test_worker_1, public;

-- Checking the current search_path
SHOW search_path;


-- 6. Removing the test schema after testing is finished (Lectures 286–288)
RESET search_path;
DROP SCHEMA IF EXISTS test_worker_1 CASCADE;