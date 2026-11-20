-- 1. Creating the users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    username VARCHAR(30) NOT NULL UNIQUE,
    bio VARCHAR(400),
    avatar VARCHAR(200),
    phone VARCHAR(25),
    email VARCHAR(40) UNIQUE,
    password VARCHAR(50),
    status VARCHAR(15)
);

-- 2. Creating the posts table and storing post details
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    url VARCHAR(200) NOT NULL,
    caption VARCHAR(240),
    lat REAL CHECK (lat IS NULL OR (lat >= -90 AND lat <= 90)),
    lng REAL CHECK (lng IS NULL OR (lng >= -180 AND lng <= 180)),
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Creating the comments table to store comments on posts
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    contents VARCHAR(240) NOT NULL,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE
);

-- 4. Creating the likes table for likes on posts and comments
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER REFERENCES posts(id) ON DELETE CASCADE,
    comment_id INTEGER REFERENCES comments(id) ON DELETE CASCADE,
    CHECK (
        (post_id IS NOT NULL AND comment_id IS NULL) OR
        (post_id IS NULL AND comment_id IS NOT NULL)
    ),
    UNIQUE (user_id, post_id),
    UNIQUE (user_id, comment_id)
);

-- 5. Creating tables to handle photo tags and caption tags
CREATE TABLE photo_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    x INTEGER NOT NULL,
    y INTEGER NOT NULL,
    UNIQUE (user_id, post_id)
);

CREATE TABLE caption_tags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    UNIQUE (user_id, post_id)
);

-- 6. Creating hashtags, connecting them to posts and setting up followers
CREATE TABLE hashtags (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE hashtags_posts (
    id SERIAL PRIMARY KEY,
    post_id INTEGER NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    hashtag_id INTEGER NOT NULL REFERENCES hashtags(id) ON DELETE CASCADE,
    UNIQUE (post_id, hashtag_id)
);

CREATE TABLE followers (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    leader_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    follower_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE (leader_id, follower_id),
    CHECK (leader_id <> follower_id)
);