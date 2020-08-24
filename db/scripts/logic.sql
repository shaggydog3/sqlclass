SELECT title FROM books WHERE released_year != 2017;

SELECT title, author_lname  FROM books

SELECT title FROM books WHERE title LIKE 'W%';
SELECT title FROM books WHERE title NOT LIKE 'W%';

SELECT * FROM books WHERE released_year > 2000;

SELECT title, released_year FROM books WHERE released_year >= 2000;

SELECT title, stock_quantity FROM books WHERE stock_quantity >= 100;

select 99 > 1;
SELECT 100 > 5;

SELECT title, author_lname FROM books
WHERE author_lname = 'Eggers' AND released_year > 2010;

SELECT title, author_lname FROM books
WHERE author_lname = 'Eggers' && released_year > 2010;

SELECT title, released_year FROM books
WHERE released_year >= 2004 and released_year <= 2015;

-- inclusive
SELECT title, released_year FROM books
WHERE released_year BETWEEN  2004 and 2015;

SELECT title, released_year FROM books
WHERE released_year NOT BETWEEN  2004 and 2015;

SELECT CAST('2017-05-02' AS DATETIME);

SELECT name, birthdt FROM people;

SELECT name, birthdt FROM people
WHERE birthdt BETWEEN '1980-01-01' AND '2000-01-01';

SELECT title, author_lname FROM books
WHERE author_lname IN ('Carver', 'Lahiri', 'Smith');

SELECT title, released_year FROM books
WHERE released_year NOT IN (
    2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016
    );

SELECT title, released_year FROM books
WHERE released_year >= 2000 AND
released_year %2 != 0;

SELECT title, released_year,
    CASE
        WHEN released_year >= 2000 THEN 'Modern Lit'
        ELSE '20th Century Lit'
    END AS GENRE
FROM books;

SELECT title, stock_quantity,
    CASE
        WHEN stock_quantity BETWEEN 0 AND 50 THEN '*'
        WHEN stock_quantity BETWEEN 51 AND 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

SELECT title, stock_quantity,
    CASE
        WHEN stock_quantity <= 50 THEN '*'
        WHEN stock_quantity <= 100 THEN '**'
        ELSE '***'
    END AS STOCK
FROM books;

-- exercises

/* evaluate:
select 10 != 10;
False

select 15 > 14 && 99 - 5 <= 94;
True

select 1 in (5, 3)  || 9 BETWEEN 8 AND 10;
True

-- select all books written before 1980 (non-inclusive)
SELECT title, released_year FROM books
WHERE released_year < 1980;

-- select all books written by eggers or chabon
SELECT title, author_lname FROM books
WHERE author_lname in ('chabon', 'Eggers');

-- select all books written by lahiri published after 2000
SELECT title, author_lname, released_year FROM books
WHERE author_lname = 'Lahiri'
AND released_year > 2000;

-- select all books with page counts between 100 and 200
SELECT title, pages FROM books
WHERE pages BETWEEN 100 AND 200;

-- select all books where author_lname starts with a 'C' or an 'S'
SELECT title, author_lname FROM books
WHERE author_lname LIKE 'C%' OR author_lname LIKE 'S%';

ALTERNATIVELY...
SELECT title, author_lname FROM books
WHERE SUBSTR(author_lname,1,1) in ('C', 'S');

/*if title contains 'stories' -> 'Short Stories'
'just kids and a hearbreaking work -> memoir
everything else -> Novel*/
SELECT title, author_lname,
    CASE
        WHEN title LIKE '%stories%' THEN 'Short Stories'
        WHEN title in ('Just kids', 'a heartbreaking work of staggering genius') THEN 'Memoir'
        ELSE 'Novel'
    END AS TYPE
FROM books;

/*Bonus: Make this happen
title, author_lname, count, show how many books/book (plural)*/
SELECT author_fname, author_lname,
    CASE
        WHEN count(*) = 1 THEN CONCAT(COUNT(*), ' book')
        ELSE CONCAT(COUNT(*), ' books')
    END AS COUNT
FROM books
GROUP BY author_fname, author_lname
ORDER BY author_lname;