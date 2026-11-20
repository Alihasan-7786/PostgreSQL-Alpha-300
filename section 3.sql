-- 1. CREATING TABLES WITH PRIMARY KEYS


-- Creating a users table where each user gets a unique ID automatically
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL
);


-- 2. CONNECTING TABLES USING FOREIGN KEYS

-- Creating a photos table and linking each photo to a user
CREATE TABLE photos (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id)
);

-- Creating a comments table to store comments made by users on photos
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    contents VARCHAR(240) NOT NULL,
    user_id INTEGER REFERENCES users(id),
    photo_id INTEGER REFERENCES photos(id)
);


-- 3. ADDING DATA AND CHECKING TABLE RECORDS


-- Adding a photo for a user who already exists
INSERT INTO photos (url, user_id)
VALUES 
('https://one.jpg', 1),
('https://two.jpg', 1),
('https://15.jpg', 1),
('https://44.jpg', 2),
('https://784.jpg', 2),
('https://79.jpg', 3),
('https://554.jpg', 4);

-- Adding a photo without assigning it to any user
INSERT INTO photos (url, user_id)
VALUES ('https://example.com/unassigned.jpg', NULL);

-- This will give an error because user ID 999 is not present in the users table
-- INSERT INTO photos (url, user_id)
-- VALUES ('https://example.com/broken.jpg', 999);

-- Displaying all photos uploaded by user with ID 1
SELECT *
FROM photos
WHERE user_id = 1;


-- 4. DIFFERENT WAYS TO HANDLE DELETING USERS

-- Preventing a user from being deleted if their photos still exist
CREATE TABLE photos_restrict (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE RESTRICT
);

-- Deleting all related photos automatically when a user is deleted
CREATE TABLE photos_cascade (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE
);

-- Keeping the photos but setting their user_id to NULL when the user is deleted
CREATE TABLE photos_set_null (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE SET NULL
);

-- Setting user_id to its default value when the user is deleted
CREATE TABLE photos_set_default (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE SET DEFAULT
);

-- Preventing deletion if it violates the foreign key constraint
CREATE TABLE photos_no_action (
    id SERIAL PRIMARY KEY,
    url VARCHAR(200) NOT NULL,
    user_id INTEGER REFERENCES users(id) ON DELETE NO ACTION
);

-- Deleting a user to check how the foreign key delete rules work
DELETE FROM users
WHERE id = 1;
-- Other options for handling foreign keys when a user is deleted:

-- on delete set null , sets the user_id to NULL when the user is deleted
-- on delete restrict , does not allow deleting a user if their posts still exist
-- on delete no action , checks the foreign key constraint at the end of the statement/transaction
-- primary keys are the keys which are uniquely identfied every record in the table 
--foreign key are the keys which refrence the primary keys of the parent table .
--one to many a mother is connected with many daughter 
-- many to one , many students are connected with one class 
-- one to one , one student have one desk or one boat have one captain
-- many to many , many employee have many task 

