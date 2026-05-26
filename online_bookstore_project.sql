# creating Database
CREATE DATABASE OnlineBookstore;

# switch to the database
USE OnlineBookstore;

# Create Tables
CREATE TABLE Books(
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(30),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
    
    
);

CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50),
    Country VARCHAR(50)
);


CREATE TABLE Orders (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    Customer_ID INT,
    Book_ID INT,
    Order_Date DATE,
    Quantity INT,
    Total_Amount DECIMAL(10,2),

    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);
    
  
    
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
    WHERE Genre = "Fiction";


-- 2) Find books published after the year 1950:
SELECT * FROM Books
    WHERE published_year>1950;
    

-- 3) List all customers from the Canada:
SELECT * FROM customers
    WHERE country= "Canada";


-- 4) Show orders placed in November 2023:

SELECT * FROM orders
    WHERE Order_Date BETWEEN '2023-11-01' And '2023-11-30';

-- 5) show total order place in November 2023:

SELECT COUNT(*) AS total_orders
    FROM orders
    WHERE Order_Date BETWEEN '2023-11-01' And '2023-11-30';


-- 6) Retrieve the total stock of books available:

SELECT SUM(stock) AS total_stock
    FROM books;
    


-- 7) Find the details of the most expensive book:

SELECT * FROM books
    ORDER BY price DESC
    LIMIT 1;


-- 8) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM orders
    WHERE quantity>1;


-- 9) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM orders
    WHERE total_amount > 20;


-- 10) List all genres available in the Books table:

SELECT DISTINCT Genre FROM Books;
 -- we use DISTINCT for unique product/type

-- 11) Find the book with the lowest stock:

SELECT * FROM books
    ORDER BY stock
    LIMIT 1;

-- 12) Calculate the total revenue generated from all orders:
SELECT SUM(total_amount) AS Revenue
    FROM Orders;


-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:

SELECT Books.Genre,
	SUM(Orders.Quantity) AS Total_Books_Sold
    FROM Books JOIN Orders
    ON Books.Book_ID = Orders.Book_ID
    GROUP BY Books.Genre;
    

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS AVERAGE_PRICE
    FROM books
    WHERE genre= "Fantasy";


-- 3) List customers who have placed at least 2 orders:
SELECT c.customer_id,
       c.name,
       COUNT(o.order_id) AS Total_Orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(o.order_id) >= 2;

    
    SELECT o.customer_id, c.name, COUNT(o.Order_id) AS ORDER_COUNT
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY o.customer_id, c.name
HAVING COUNT(Order_id) >=2;


-- 4) Find the most frequently ordered book:

SELECT o.Book_id, b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY o.book_id, b.title
ORDER BY ORDER_COUNT DESC LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT * FROM books
    WHERE genre= "Fantasy"
    ORDER BY price DESC LIMIT 3;


-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author,
       SUM(o.quantity) AS Total_Books_Sold
FROM books b
JOIN orders o
ON b.book_id = o.book_id
GROUP BY b.author;


-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.Total_Amount > 30;


-- 8) Find the customer who spent the most on orders:
SELECT c.customer_id,
       c.name,
       SUM(o.Total_Amount) AS Total_Spent
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC
LIMIT 1;




-- 9) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, 
       b.title, 
       b.stock, 
       COALESCE(SUM(o.quantity),0) AS Order_quantity,  
       b.stock - COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o 
ON b.book_id = o.book_id
GROUP BY b.book_id
ORDER BY b.book_id;

 






