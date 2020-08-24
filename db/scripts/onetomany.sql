-- Create tables for one to many lesson

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Populate with data.

INSERT INTO customers (first_name, last_name, email)
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');

INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);

-- This fails because of the foreign key constraint:
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/06/06', 33.67, 98);

-- Querying the related data:

-- long-winded way (not the right way)
SELECT * FROM customers WHERE last_name='George';
SELECT * FROM orders WHERE customer_id=1;

-- using subquery (also not the best way):
SELECT * FROM orders WHERE customer_id=(
    SELECT id FROM customers WHERE last_name='George');

-- selecting from both tables (you can do it, but the result is not meaningful in this case)
-- implicit or cross join:
SELECT * FROM customers, orders;

-- using an implicit, or inner join, but restricting to :
SELECT * FROM customers, orders WHERE customers.id = orders.customer_id;
SELECT first_name, last_name, order_date, amount
FROM customers, orders
    WHERE customers.id = orders.customer_id;

-- explicit inner join; create the union table
SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders
    ON customers.id = orders.customer_id;

SELECT first_name, last_name, order_date, amount FROM customers
JOIN orders
    ON customers.id = orders.customer_id
ORDER BY order_date;

-- (INNER is implied when specifying JOIN)
SELECT  first_name,
        last_name,
        sum(amount) AS total_spent
FROM customers
JOIN orders
    ON customers.id = orders.customer_id
GROUP BY orders.customer_id
ORDER BY total_spent DESC;

-- left join
SELECT  first_name, last_name, order_date, amount
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id;

SELECT  first_name,
        last_name,
        IFNULL(SUM(amount), 0) AS total_spent
FROM customers
LEFT JOIN orders
    ON customers.id = orders.customer_id
GROUP BY customers.id
ORDER BY total_spent DESC;

/* right join, given above data, right join doesn't give us anything different from the inner
join since there are no orders without any customers.
Instructor demonstrates this by deleting data (dropping tables), and recreating the tables
without the foreign constraint. :(
Should be relevant examples later... */

SELECT * FROM customers
RIGHT JOIN orders
    ON customers.id = orders.customer_id;

/* ON DELETE CASCADE

CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    amount DECIMAL(8,2),
    customer_id INT,
    FOREIGN KEY(customer_id)
        REFERENCES customers(id)
        ON DELETE CASCADE
);
*/

-- right join with the tables swapped:

SELECT  first_name, last_name, order_date, amount
FROM orders
RIGHT JOIN customers
    ON customers.id = orders.customer_id;

-- Exercises
/* write students and papers schema.
one student can have multiple papers
students has an id, and first_name
papers has a title, grade, and student_id*/

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)
);

CREATE TABLE papers (
    title VARCHAR(100),
    grade INT,
    student_id INT,
    FOREIGN KEY(student_id)
        REFERENCES students(id)
);

-- insert data:

INSERT INTO students (first_name) VALUES
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

-- print first table, with first_name, title, grade
SELECT first_name, title, grade from papers
INNER JOIN students
    ON papers.student_id = students.id
    ORDER BY grade DESC;
-- in instructor example, he had students on left, and papers on right.  He also ordered by grade.

-- first_name, title, grade; show students without papers.
SELECT first_name, title, grade
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id;

-- first_name, title, grade; all students without papers, but substitute MISSING where title is
-- not there, and 0 for grade.
SELECT first_name,
    IFNULL(title, 'MISSING') AS title,
    IFNULL(grade, 0) AS grade
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id;

-- first_name, average (average grade for student), include students without papers,
-- show 0 where no papers were submitted.
SELECT first_name,
    IFNULL(AVG(grade), 0) AS average
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;

SELECT first_name,
    IFNULL(AVG(grade), 0) AS average
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id
GROUP BY students.id
ORDER BY average DESC;

-- first_name, average, passing_status; similar to previous.  threshold is 75 or higher
-- PASSING, FAILING

SELECT first_name,
    IFNULL(AVG(grade), 0) AS average,
    CASE
        WHEN AVG(grade) >= 75 THEN 'PASSING'
        ELSE 'FAILING'
    END AS passing_status
FROM students
LEFT JOIN papers
    ON papers.student_id = students.id
GROUP BY first_name
ORDER BY average DESC;

-- observed that CASE cannot access aliases, so in above example, I had to re-state the
-- AVG call.