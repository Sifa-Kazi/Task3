-- Display first 10 records
SELECT *
FROM sales_data_sample
LIMIT 10;

-- Display top 5 orders by sales
SELECT ORDERNUMBER, SALES, CUSTOMERNAME
FROM sales_data_sample
ORDER BY SALES DESC
LIMIT 5;

-- Display orders where sales are above average
SELECT *
FROM sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM sales_data_sample)
ORDER BY SALES DESC;

-- Calculate total and average sales per product line
SELECT PRODUCTLINE, SUM(SALES) AS TotalSales, AVG(SALES) AS AvgSales
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY TotalSales DESC;

-- Inner join sales with customers to get detailed info
SELECT s.ORDERNUMBER, s.SALES, c.CUSTOMERNAME, c.EMAIL, c.COUNTRY
FROM sales_data_sample s
INNER JOIN customers c
ON s.CUSTOMERNAME = c.CUSTOMERNAME
LIMIT 10;

-- Left join sales with customers to include all sales
SELECT s.ORDERNUMBER, s.SALES, c.CUSTOMERNAME, c.EMAIL
FROM sales_data_sample s
LEFT JOIN customers c
ON s.CUSTOMERNAME = c.CUSTOMERNAME
LIMIT 10;

-- Display orders with sales above average
SELECT ORDERNUMBER, SALES
FROM sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM sales_data_sample);

-- Customers with total sales greater than 50000
SELECT CUSTOMERNAME
FROM sales_data_sample
GROUP BY CUSTOMERNAME
HAVING SUM(SALES) > 50000;


DROP INDEX IF EXISTS idx_sales;
DROP INDEX IF EXISTS idx_customername;

-- Create indexes to optimize queries
CREATE INDEX idx_sales ON sales_data_sample(SALES);
CREATE INDEX idx_customername ON sales_data_sample(CUSTOMERNAME);
PRAGMA index_list('sales_data_sample');

DROP VIEW IF EXISTS HighValueOrders;

-- Create view for high value orders (sales > 10000)
CREATE VIEW HighValueOrders AS
SELECT ORDERNUMBER, SALES, CUSTOMERNAME
FROM sales_data_sample
WHERE SALES > 10000;
SELECT * FROM HighValueOrders;
