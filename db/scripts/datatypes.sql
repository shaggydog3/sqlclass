/* CREATE TABLE people (
name VARCHAR(100),
birthdate DATE,
birthtime TIME,
birthdt datetime
); */

-- Timestamps

CREATE TABLE comments (
    content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments2 (
    content VARCHAR(100),
    changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
);

-- excersises

-- what's a good use case for char
-- UUID/ serial number

-- What should the datatype be? (prices are always less than 1,000,000)
CREATE TABLE inventory (
    item_name VARCHAR(10),
    price DECIMAL(8,2)
    quantity INT
)

-- What's the difference between DATETIME and TIMESTAMP?
-- TIMESTAMP has a range of 1970 Jan 1 to 2038 Jan 19.  Datetime has a range from 1000-01-01 to
-- 9999-12-31

-- Print out the curent time
select now()

-- Print out the current date (not the time)
select DATE(CURRENT_DATE())

-- Print out the current day of the week
SELECT DAYOFWEEK(NOW());

-- Print out the day name of the current day of the week.
SELECT DAYNAME(NOW());

--- Print out the current day and time using this format: mm/dd/yyyy
SELECT DATE_FORMAT(NOW(),'%m/%d/%Y')

-- Print out the current day and time using this format:
--   January 2nd at 3:15
--   April 1st at 10:18
SELECT DATE_FORMAT(NOW(), '%M %D at %l:%i');

-- Create a tweets table that stores:
--  the tweet content
--  a username
--  time it was created.

CREATE TABLE tweets (
    content VARCHAR(1000),
    username VARCHAR(50),
    create_time TIMESTAMP DEFAULT NOW()
);