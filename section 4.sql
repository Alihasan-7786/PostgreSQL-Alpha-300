-- 1. INNER JOIN (Getting Matching Records)

-- Getting photo details along with the username of the person who uploaded them
SELECT p.id AS photo_id, p.url, u.username
FROM photos AS p
INNER JOIN users AS u
    ON p.user_id = u.id;

-- Getting users and their uploaded photos using JOIN
SELECT u.id AS user_id, u.username, p.url
FROM users u
JOIN photos p
    ON u.id = p.user_id;


-- 2. LEFT OUTER JOIN (Keeping All Users)

-- Showing all users along with their photos, even if they have not uploaded any
SELECT u.username, p.url
FROM users u
LEFT OUTER JOIN photos p
    ON u.id = p.user_id;

-- Using LEFT JOIN to get the same result as LEFT OUTER JOIN
SELECT u.username, p.url
FROM users u
LEFT JOIN photos p
    ON u.id = p.user_id;

-- Finding users who have not uploaded any photos yet
SELECT u.username, p.url
FROM users u
LEFT JOIN photos p
    ON u.id = p.user_id
WHERE p.id IS NULL;


-- 3. RIGHT OUTER JOIN (Keeping All Photos)

-- Showing all photos along with their usernames, even if no matching user is found
SELECT u.username, p.url
FROM users u
RIGHT OUTER JOIN photos p
    ON u.id = p.user_id;

-- Using RIGHT JOIN to get the same result as RIGHT OUTER JOIN
SELECT u.username, p.url
FROM users u
RIGHT JOIN photos p
    ON u.id = p.user_id;


-- 4. FULL OUTER JOIN (Keeping All Records)

-- Showing all users and photos, including records that do not have a match
SELECT u.username, p.url
FROM users u
FULL OUTER JOIN photos p
    ON u.id = p.user_id;

-- Using FULL JOIN to get the same result as FULL OUTER JOIN
SELECT u.username, p.url
FROM users u
FULL JOIN photos p
    ON u.id = p.user_id;


-- 5. JOINING MULTIPLE TABLES

-- Getting comments along with the photo URL and username of the person who commented
SELECT c.contents, p.url AS photo_url, u.username AS commenter
FROM comments c
JOIN photos p
    ON c.photo_id = p.id
JOIN users u
    ON c.user_id = u.id;

-- Getting photos uploaded by a particular user using JOIN and WHERE
SELECT u.username, p.url
FROM users u
JOIN photos p
    ON u.id = p.user_id
WHERE u.username = 'Reyna.Marvin';