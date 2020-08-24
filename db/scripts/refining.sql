SELECT DISTINCT author_lname FROM books;

SELECT DISTINCT CONCAT(author_fname, ' ', author_lname) FROM books;

SELECT DISTINCT author_fname, author_lname FROM books;

SELECT author_lname FROM books ORDER BY author_lname DESC;

SELECT title FROM books ORDER BY title DESC;

SELECT released_year FROM books ORDER BY released_year ASC;

SELECT title, pages FROM books ORDER BY released_year;

SELECT title, author_fname, author_lname
FROM books ORDER BY 2;

SELECT author_fname, author_lname FROM books ORDER BY author_lname, author_fname;

SELECT title, released_year FROM books ORDER BY released_year DESC LIMIT 1,3;

/* Like */

SELECT title, author_fname FROM books WHERE author_fname LIKE '%da%';

SELECT title, author_fname FROM books WHERE author_fname LIKE 'da%';

SELECT title FROM books WHERE title LIKE '%the%';

SELECT title, stock_quantity FROM books WHERE stock_quantity LIKE '____';

SELECT title FROM books WHERE title LIKE '%\_%';

-- Excersises...
-- Find all books where the title contains "stories"
SELECT title FROM books WHERE title LIKE '%stories%';

-- Find the longest book.
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;

-- show summary of 3 most recently released books
SELECT CONCAT(title, ' - ', released_year) AS summary FROM books
ORDER BY released_year DESC
LIMIT 3;

-- Show all the books where the author's last name contains a space.
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';

-- find 3 books with the lowest stock.
SELECT title, released_year, stock_quantity FROM books ORDER BY stock_quantity LIMIT 3;

-- print the title, and author last name, sorted by the author last name, and title.
SELECT title, author_lname FROM books ORDER BY author_lname, title ;

SELECT UPPER(CONCAT('my favorite author is ', author_fname, ' ', author_lname, '!')) AS yell
FROM books
ORDER BY author_lname;