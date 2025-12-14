
SELECT *
FROM sales_data_sample
LIMIT 10;

SELECT ORDERNUMBER, SALES, CUSTOMERNAME
FROM sales_data_sample
ORDER BY SALES DESC
LIMIT 5;

SELECT *
FROM sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM sales_data_sample)
ORDER BY SALES DESC;

SELECT PRODUCTLINE, SUM(SALES) AS TotalSales, AVG(SALES) AS AvgSales
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY TotalSales DESC;

SELECT s.ORDERNUMBER, s.SALES, c.CUSTOMERNAME, c.EMAIL, c.COUNTRY
FROM sales_data_sample s
INNER JOIN customers c
ON s.CUSTOMERNAME = c.CUSTOMERNAME
LIMIT 10;

SELECT s.ORDERNUMBER, s.SALES, c.CUSTOMERNAME, c.EMAIL
FROM sales_data_sample s
LEFT JOIN customers c
ON s.CUSTOMERNAME = c.CUSTOMERNAME
LIMIT 10;

SELECT ORDERNUMBER, SALES
FROM sales_data_sample
WHERE SALES > (SELECT AVG(SALES) FROM sales_data_sample);

SELECT CUSTOMERNAME
FROM sales_data_sample
GROUP BY CUSTOMERNAME
HAVING SUM(SALES) > 50000;


DROP INDEX IF EXISTS idx_sales;
DROP INDEX IF EXISTS idx_customername;

CREATE INDEX idx_sales ON sales_data_sample(SALES);
CREATE INDEX idx_customername ON sales_data_sample(CUSTOMERNAME);
PRAGMA index_list('sales_data_sample');

DROP VIEW IF EXISTS HighValueOrders;

CREATE VIEW HighValueOrders AS
SELECT ORDERNUMBER, SALES, CUSTOMERNAME
FROM sales_data_sample
WHERE SALES > 10000;
SELECT * FROM HighValueOrders;
