-- challenges based on the ig_clone_data provided by the course

-- find the 5 oldest users

SELECT username, created_at
FROM users
ORDER BY created_at
LIMIT 5;

-- What day of the week do most users register on?

SELECT
    DAYNAME(created_at) AS registerday,
    count(username) AS daycount
FROM users
GROUP BY registerday
ORDER BY daycount DESC
-- LIMIT 1 (since there are two days tying for highest value, limit doesn't give the complete
--          picture)
;

-- Find the users who have never posted a photo

SELECT username
FROM users
LEFT JOIN photos
    ON photos.user_id = users.id
WHERE photos.id IS NULL;

-- who got the most likes on a single photo?

SELECT
    photo_id,
    count(*) AS total
FROM likes
GROUP BY photo_id
ORDER BY total DESC
LIMIT 5;

SELECT photo_id, count(*) as likecount, users.username
FROM photos
JOIN likes
    ON photos.id = likes.photo_id
JOIN users
    ON photos.user_id = users.id
GROUP BY likes.photo_id
ORDER BY likecount DESC
-- LIMIT 5
;

-- how many times does the average user post?
-- Question: Do we include users that have not posted (as a zero)?

-- SELECT(
--    SELECT
--        count(*) AS total
--    FROM photos
--    GROUP BY user_id;
--    );
/* didn't quite get this, was trying to select only users that posted, and not including
 all users.  From looking online, I could have done it using a subquery, which I have partially
 implemented above.*/

-- total number of photos / total number of users... ?

SELECT (SELECT COUNT(*)
    FROM photos) /
    (SELECT COUNT(*) FROM users) AS avg;

-- What are the top 5 most commonly used hashtags?
SELECT
    tag_name,
    COUNT(*) AS total
FROM photo_tags
JOIN tags
    ON photo_tags.tag_id = tags.id
GROUP BY tag_id
ORDER BY total DESC
LIMIT 5;
-- Again, there are some hashtags tied for 5th place.

-- Find users who have liked every single photo on the site.

SELECT
    username,
    count(*) as total
FROM likes
JOIN users
    ON likes.user_id = users.id
GROUP BY user_id
HAVING total = (SELECT COUNT(*) FROM photos);

-- new concept "HAVING"

SELECT COUNT(*) FROM photos;