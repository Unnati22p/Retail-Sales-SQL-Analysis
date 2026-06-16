-- Retail Sales Analysis Using SQL

-- Create Database
CREATE DATABASE retail_sales_db;

-- Select Database
USE retail_sales_db;

-- Create Table
CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    product_category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    total_amount DECIMAL(10,2)
);
-- View First 10 Records

SELECT *
FROM retail_sales
LIMIT 10;

-- Total Revenue

SELECT
    SUM(total_amount) AS total_revenue
FROM retail_sales;

-- Total Transactions

SELECT
    COUNT(*) AS total_transactions
FROM retail_sales;

-- Revenue by Product Category

SELECT
    product_category,
    SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY product_category
ORDER BY revenue DESC;

-- Top 5 Customers by Spending

SELECT
    customer_name,
    SUM(total_amount) AS spending
FROM retail_sales
GROUP BY customer_name
ORDER BY spending DESC
LIMIT 5;

-- Monthly Revenue Trend

SELECT
    MONTH(sale_date) AS month,
    SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY month
ORDER BY month;

-- Average Spending by City

SELECT
    city,
    ROUND(AVG(total_amount),2) AS avg_spending
FROM retail_sales
GROUP BY city;

-- Product Category Contribution (%)

SELECT
    product_category,
    ROUND(
        SUM(total_amount) * 100 /
        (SELECT SUM(total_amount) FROM retail_sales),
        2
    ) AS revenue_percentage
FROM retail_sales
GROUP BY product_category
ORDER BY revenue_percentage DESC;

-- Most Sold Products

SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;

-- Highest Revenue Products

SELECT
    product_name,
    SUM(total_amount) AS revenue
FROM retail_sales
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 10;

-- Transactions by City

SELECT
    city,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY city
ORDER BY total_transactions DESC;

-- Average Unit Price by Category

SELECT
    product_category,
    ROUND(AVG(unit_price),2) AS avg_price
FROM retail_sales
GROUP BY product_category;

-- Revenue Ranking of Categories

SELECT
    product_category,
    SUM(total_amount) AS revenue,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS revenue_rank
FROM retail_sales
GROUP BY product_category;
