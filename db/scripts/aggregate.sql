-- Based on book_shop.sql

-- aggregate functions...

SELECT COUNT(DISTINCT author_fname) FROM books;

SELECT COUNT(DISTINCT author_fname, author_lname) FROM books;

SELECT COUNT(*) FROM books WHERE title LIKE '%the%';

SELECT author_fname, author_lname, COUNT(*) FROM books
GROUP BY author_fname, author_lname ;

SELECT CONCAT('In ', released_year, ' ', count(*), ' books were released.') as year
FROM books GROUP BY released_year;

-- Min & Max

SELECT min(released_year) FROM books;

-- this doesn't work...
SELECT MAX(pages), title FROM books;

-- subqueries...
SELECT MAX(pages) from books;
SELECT title, pages FROM books where pages = (SELECT MAX(pages) from books);

SELECT title, pages FROM books ORDER BY pages ASC LIMIT 1;

SELECT author_fname, author_lname, MIN(released_year)
FROM books
GROUP BY author_lname, author_fname;

select sum(pages) FROM books;

select author_lname, author_fname, sum(pages) from books
GROUP BY author_lname, author_fname;

select avg(released_year) from books;

SELECT released_year, AVG(stock_quantity) FROM books GROUP BY released_year;

-- print number of books in the database
SELECT COUNT(*) FROM books;

-- print out how many books were released in each year.
select released_year, count(*) FROM books GROUP BY released_year

-- print out the total number of books in stock
SELECT SUM(stock_quantity) FROM books;

-- find the average released_year for each author
SELECT author_fname, author_lname, AVG(released_year) FROM books GROUP BY author_lname, author_fname;

-- find the full name first name last name of the author who wrote the longest book
SELECT CONCAT(author_fname, ' ', author_lname), pages from books ORDER BY pages DESC LIMIT 1;

-- year, number of books released in that year, average number of pages for those books.
SELECT released_year, count(*), AVG(pages) from books
GROUP BY released_year
ORDER BY released_year;