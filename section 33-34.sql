-- SECTION 33 & 34: API ACCESS & REPOSITORY PATTERN

-- 1. Creating the users table for API and repository examples (Lectures 254–255, 260–264)
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(30) NOT NULL UNIQUE,
    bio VARCHAR(400)
);


-- 2. Getting all users and changing column names to camelCase (Lectures 262–263)
SELECT
    id,
    created_at AS "createdAt",
    updated_at AS "updatedAt",
    username,
    bio
FROM users
ORDER BY id;


-- 3. Getting a particular user using their ID (Lecture 264 — parameterized $1 placeholder)
SELECT
    id,
    created_at AS "createdAt",
    updated_at AS "updatedAt",
    username,
    bio
FROM users
WHERE id = $1;


-- 4. Adding a new user and getting the inserted details back (Lecture 260 / Section 35 preview)
INSERT INTO users (username, bio)
VALUES ($1, $2)
RETURNING
    id,
    created_at AS "createdAt",
    updated_at AS "updatedAt",
    username,
    bio;