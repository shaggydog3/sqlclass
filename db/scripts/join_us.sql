-- Scripts relating to the "join us" sample app from the sql class.

CREATE DATABASE join_us;

CREATE TABLE users (
    email VARCHAR(255) PRIMARY KEY,
    created_at  TIMESTAMP DEFAULT NOW()
);

INSERT INTO users (email) VALUES
('Katie34@yahoo.com'), ('Tunde@gmail.com');

-- EXERCISES

-- Find earliest_date; formatted like May 2nd 2016

SELECT DATE_FORMAT(created_at, '%b %D %Y') AS earliest_date
FROM users
ORDER BY created_at
LIMIT 1;

-- or...

SELECT DATE_FORMAT(MIN(created_at), "%M %D %Y") as earliest_date
FROM users;

-- Find the email of the earliest user.

SELECT email, created_at
FROM users
ORDER BY created_at
LIMIT 1;

-- Table of "month", "count"; count of the number of users that joined in a given month.

SELECT
    MONTHNAME(created_at) AS create_month,
    COUNT(*) AS count
FROM users
GROUP BY create_month
ORDER BY count DESC;

-- Count the number of 'yahoo_users'

SELECT COUNT(*) AS yahoo_users
FROM users
WHERE email LIKE('%@yahoo.com');

-- Calculate the total number of users for each email host; 'provider', 'total_users'; providers are
-- gmail, yahoo, hotmail & other

SELECT
    CASE
        WHEN email LIKE('%@gmail.com') THEN 'gmail'
        WHEN email LIKE('%@yahoo.com') THEN 'yahoo'
        WHEN email LIKE('%@hotmail.com') THEN 'hotmail'
        ELSE 'other'
    END AS provider,
    count(*) AS total_users
FROM users
GROUP BY provider
ORDER BY total_users;
