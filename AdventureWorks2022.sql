;-- Print the information about all the Sales.Person and their sales quota. For every Sales person you should provide their FirstName, 
-- LastName, HireDate, SickLeaveHours and Region where they work.
SELECT 
	e.FirstName, 
	e.LastName, 
	s.SalesAmountQuota, 
	e.SickLeaveHours, 
	e. StartDate as HireDate,
	t. SalesTerritoryRegion
FROM 
	DimEmployee e
	INNER JOIN FactSalesQuota s
	ON e.EmployeeKey = s.EmployeeKey
	INNER JOIN DimSalesTerritory t
	ON e.SalesTerritoryKey = t.SalesTerritoryKey

-- Average Money Spent on an Order
SELECT 
	AVG(TotalProductCost) AS AvgMoneySpent 
FROM 
	[dbo].[FactInternetSales]

-- Total Sales in the Second Quarter of Each Year
SELECT 
	YEAR(d.FullDateAlternateKey) AS 'year',
	SUM(CASE WHEN MONTH(d.FullDateAlternateKey) BETWEEN '4' AND '6' THEN i.TotalProductCost END) AS 'Q2sales'
FROM 
	[dbo].[DimDate] d
	JOIN FactInternetSales i
	ON d.DateKey = i.OrderDateKey
GROUP BY 
	YEAR(d.FullDateAlternateKey)
ORDER BY 
	YEAR(d.FullDateAlternateKey);

-- Sales Performance by Year
SELECT 
	YEAR(d.FullDateAlternateKey) AS 'year',
	SUM(i.TotalProductCost) AS 'TotalRevenue',
	(((SUM(i.TotalProductCost) - LAG(SUM(i.TotalProductCost)) OVER (ORDER BY YEAR(d.FullDateAlternateKey))) 
	/ LAG(SUM(i.TotalProductCost)) OVER (ORDER BY YEAR(d.FullDateAlternateKey))) * 100) AS 'SalesGrowthPercentage'
FROM 
	DimDate d
	JOIN FactInternetSales i
	ON d.DateKey = i.OrderDateKey
GROUP BY 
	YEAR(d.FullDateAlternateKey);

-- Total Order Amount of Categories by Year
SELECT 
	YEAR(d.FullDateAlternateKey) AS 'Year',
	COUNT(*) AS OrderAmount
FROM 
	FactInternetSales i
	JOIN DimDate d
	ON d.DateKey = i.OrderDateKey
GROUP BY 
	YEAR(d.FullDateAlternateKey)
ORDER BY
	YEAR(d.FullDateAlternateKey)

-- Total Sales for Each Product Category
SELECT 
	c.[EnglishProductCategoryName],
	COUNT(*) AS Sales
FROM 
	[dbo].[FactInternetSales] i
	JOIN [dbo].[DimProduct] dp
	ON  i.ProductKey = dp.ProductKey
	JOIN [dbo].[DimProductSubcategory] dps
	ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
	JOIN [dbo].[DimProductCategory] c
	ON dps.ProductCategoryKey = c.ProductCategoryKey
GROUP BY c.[EnglishProductCategoryName]

-- Total Sales Amount of Sub-Categories of Bike Category (Best sales performance in categories)
SELECT 
	[EnglishProductSubcategoryName],
	SUM(SalesAmount) AS TotalSalesAmount	
FROM 
	[dbo].[FactInternetSales] i
	JOIN [dbo].[DimProduct] p
	ON i.ProductKey = p.ProductKey
	JOIN [dbo].[DimProductSubcategory] ps
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
GROUP BY [EnglishProductSubcategoryName]

-- Find the customers who have not placed any orders
SELECT * 
FROM DimCustomer c
	LEFT JOIN FactInternetSales i
	ON c.CustomerKey = i.CustomerKey
WHERE i.OrderDateKey IS NULL;

-- Calculate the total number of orders and total sales amount for each customer
SELECT 
	CustomerKey,
	COUNT(*) AS NumOfOrder, 
	SUM(TotalProductCost) AS TotalSpent
FROM 
	FactInternetSales
GROUP BY 
	CustomerKey

-- Calculate the total sales amount for each month for 2005 
SELECT 
    MONTH(d.FullDateAlternateKey) AS Month
FROM 
    DimDate d
WHERE 
    YEAR(d.FullDateAlternateKey) = '2006'
GROUP BY 
    MONTH(d.FullDateAlternateKey)


-- Find the top 3 customers with highest average order amount
SELECT TOP (3) 
    CustomerKey, 
    AVG(TotalProductCost) AS AvgOrderAmt
FROM 
    FactInternetSales
GROUP BY 
    CustomerKey
ORDER BY 
    AVG(TotalProductCost) DESC


-- List the top 5 products by total sales amount
SELECT TOP (5) 
    ProductKey, 
    SUM(TotalProductCost) AS OrderAmt
FROM 
    FactInternetSales
GROUP BY 
    ProductKey
ORDER BY 
    SUM(TotalProductCost) DESC

-- Find the average number of days between order date and ship date for each products
SELECT 
	AVG(ShipDateKey - OrderDateKey) AS AvgShipTime
FROM 
	FactInternetSales

-- What is the number of products in each category?
SELECT 
	c.EnglishProductCategoryName,
	COUNT(p.ProductKey) AS NumOfProducts
FROM 
	DimProduct p
	JOIN DimProductSubcategory s
	ON s.ProductSubcategoryKey = p.ProductSubcategoryKey
	JOIN DimProductCategory c
	ON s.ProductCategoryKey = c.ProductCategoryKey
GROUP BY 
	c.EnglishProductCategoryName
	
-- Top 10 Employees with the highest sale
SELECT TOP(10)
	CONCAT(FirstName, ' ', LastName) AS FullName,
	SUM(TotalProductCost) AS TotalSales
FROM 
	FactResellerSales s
	JOIN DimEmployee e
	ON s.EmployeeKey = e.EmployeeKey
GROUP BY 
	CONCAT(FirstName, ' ', LastName)
ORDER BY 
	SUM(TotalProductCost) DESC

-- Distribution of order by products
SELECT 
	p.[EnglishProductName],
	COUNT(*) AS OrderCount
FROM 
	FactInternetSales i
	JOIN DimProduct p
	ON i.ProductKey = p.ProductKey
GROUP BY 
	p.[EnglishProductName]

-- Order By Country
SELECT 
	SalesOrderNumber,
	g.SalesTerritoryRegion,
	g.SalesTerritoryCountry,
	g.SalesTerritoryGroup
FROM 
	[dbo].[FactInternetSales] i
	JOIN DimSalesTerritory g
	ON G.SalesTerritoryKey = i.SalesTerritoryKey

-- Write a query to find the top 5 customers by total sales amount, including their customer names and total sales.
SELECT TOP(5)
	i.CustomerKey,
	c.FirstName,
	SUM(TotalProductCost) AS TotalSalesAmount
FROM
	FactInternetSales i
	JOIN DimCustomer c
	ON i.CustomerKey = c.CustomerKey
GROUP BY 
	i.CustomerKey,
	c.FirstName
ORDER BY
	SUM(TotalProductCost) DESC

-- Calculate the year-over-year growth rate of sales for each product category and subcategory for the last 3 years.
WITH SalesByCategoryYear AS (
    SELECT
        pc.EnglishProductCategoryName AS Category,
        ps.EnglishProductSubcategoryName AS Subcategory,
        YEAR(f.OrderDate) AS SalesYear,
        SUM(f.SalesAmount) AS TotalSales
    FROM
        FactInternetSales f
        JOIN DimProduct p ON f.ProductKey = p.ProductKey
        JOIN DimProductSubcategory ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
        JOIN DimProductCategory pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
    WHERE
        YEAR(f.OrderDate) BETWEEN YEAR(DATEADD(YEAR, -2, GETDATE())) AND YEAR(GETDATE())
    GROUP BY
        pc.EnglishProductCategoryName,
        ps.EnglishProductSubcategoryName,
        YEAR(f.OrderDate)
)
SELECT
    Category,
    Subcategory,
    SalesYear,
    TotalSales,
    LAG(TotalSales, 1) OVER (PARTITION BY Category, Subcategory ORDER BY SalesYear) AS PreviousYearSales,
    (TotalSales - LAG(TotalSales, 1) OVER (PARTITION BY Category, Subcategory ORDER BY SalesYear)) / LAG(TotalSales, 1) OVER (PARTITION BY Category, Subcategory ORDER BY SalesYear) AS YearOverYearGrowthRate
FROM
    SalesByCategoryYear
ORDER BY
    Category,
    Subcategory,
    SalesYear;

-- Write a query to find the top 10 sales representatives by total sales amount for each calendar year, including their names and total sales.
SELECT TOP(10)
	rs.EmployeeKey,CONCAT(FirstName, ' ', LastName) AS FullName, SUM(ProductStandardCost) AS TotalSalesAmount, YEAR(d.FullDateAlternateKey) AS 'Year'
FROM 
	[dbo].[FactResellerSales] rs
	JOIN DimDate d 
	ON rs.OrderDateKey = d.DateKey
	JOIN DimEmployee e
	ON e.EmployeeKey = rs.EmployeeKey
GROUP BY rs.EmployeeKey,CONCAT(FirstName, ' ', LastName), YEAR(d.FullDateAlternateKey)
ORDER BY SUM(ProductStandardCost) DESC

-- Calculate the average number of days between an order being placed and the corresponding shipment being delivered, grouped by product category and calendar year.
SELECT pc.EnglishProductCategoryName, AVG(i.ShipDateKey-i.OrderDateKey) AS AvgDiff, YEAR(d.FullDateAlternateKey) AS 'Year'
FROM [dbo].[FactInternetSales] i
JOIN DimDate d
ON d.DateKey = i.OrderDateKey
JOIN DimProduct p
ON i.ProductKey = p.ProductKey
JOIN DimProductSubcategory ps
ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
JOIN DimProductCategory pc
ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY pc.EnglishProductCategoryName, YEAR(d.FullDateAlternateKey)

-- Write a query to identify customers who have made purchases in all sales territories, including their customer names and the number of 
-- territories they've purchased from.
SELECT c.FirstName, c.LastName, COUNT(t.SalesTerritoryKey) AS TerCount
FROM 
	DimSalesTerritory t
	JOIN FactInternetSales i
	ON t.SalesTerritoryAlternateKey = i.SalesTerritoryKey
	JOIN DimCustomer c
	ON c.CustomerKey = i.CustomerKey
GROUP BY 
	c.FirstName, 
		c.LastName
HAVING 
	COUNT(t.SalesTerritoryKey) 
	= (SELECT MAX(SalesTerritoryKey) FROM DimSalesTerritory)

-- Identify the sales representatives who have the highest and lowest average order sizes, including their names and the respective average order sizes.
SELECT TOP(1)
	i.EmployeeKey,
	CONCAT(FirstName, ' ',LastName) AS FullName,
	AVG(OrderQuantity) AS AvgOrderSizeWithLowest
FROM
	[dbo].[FactResellerSales] i
	JOIN DimEmployee e
	ON e.EmployeeKey = i.EmployeeKey
GROUP BY 
	i.EmployeeKey,CONCAT(FirstName, ' ',LastName)
ORDER BY 
	AVG(OrderQuantity)

SELECT TOP(1)
	i.EmployeeKey, 
	CONCAT(FirstName, ' ',LastName) AS FullName,
	AVG(OrderQuantity) AS AvgOrderSizeWithHighest
FROM
	[dbo].[FactResellerSales] i
	JOIN DimEmployee e
	ON e.EmployeeKey = i.EmployeeKey
GROUP BY 
	i.EmployeeKey,CONCAT(FirstName, ' ',LastName)
ORDER BY 
	AVG(OrderQuantity) DESC

-- Write a query to find the products that have been sold in all sales territories, including the product names and the number of territories they've been sold in.
SELECT
	ProductKey,
	COUNT(DISTINCT(SalesTerritoryKey)) AS NumOfTerritories
FROM 
	FactResellerSales
GROUP BY 
	ProductKey
HAVING COUNT(DISTINCT(SalesTerritoryKey)) = (SELECT COUNT(*) FROM DimSalesTerritory)

-- Calculate the total sales, total profit, and profit margin for each combination of product category, product subcategory, and calendar year.
WITH Profit AS 
(
	SELECT 
		pc.EnglishProductCategoryName,
		ps.EnglishProductSubcategoryName,
		SUM(i.SalesAmount) AS TotalSales,
		SUM(i.SalesAmount - i.TotalProductCost) AS TotalProfit,
		YEAR(d.FullDateAlternateKey) AS CYear
	FROM 
		FactInternetSales i
		JOIN DimProduct p
		ON p.ProductKey = i.ProductKey
		JOIN DimProductSubcategory ps
		ON ps.ProductSubcategoryKey=p.ProductSubcategoryKey
		JOIN DimProductCategory pc
		ON pc.ProductCategoryKey=ps.ProductCategoryKey
		JOIN DimDate d
		ON i.OrderDateKey = d.DateKey
	GROUP BY
		pc.EnglishProductCategoryName,
		ps.EnglishProductSubcategoryName,
		YEAR(d.FullDateAlternateKey)
)
SELECT 
	EnglishProductCategoryName,
	EnglishProductSubcategoryName,
	CYear,
	TotalProfit,
	TotalSales,
	((TotalProfit/TotalSales)*100) AS ProfitMargin
FROM 
	Profit

-- Find the customers who have made the most number of distinct purchases (i.e., separate orders), including their customer names and the count of distinct purchases.
SELECT i.CustomerKey,CONCAT(c.FirstName, ' ', c.LastName) AS FullName, COUNT(DISTINCT(ProductKey)) DistinctCount
FROM FactInternetSales i
	JOIN DimCustomer c
	ON c.CustomerKey = i.CustomerKey
GROUP BY i.CustomerKey, CONCAT(c.FirstName, ' ', c.LastName);
	
-- Write a query to identify the sales representatives who have the highest and lowest customer retention rates, including their names 
-- and the respective retention rates.


-- Calculate the total sales and total profit for each combination of sales territory and calendar month
SELECT 
	t.SalesTerritoryRegion,
	t.SalesTerritoryCountry,
	t.SalesTerritoryGroup,
	SUM(i.SalesAmount) AS TotalSales,
	SUM(i.SalesAmount - i.TotalProductCost) AS TotalProfit,
	MONTH(d.FullDateAlternateKey) AS CMonth,
	YEAR(d.FullDateAlternateKey) AS CYear
FROM 
	FactInternetSales i
	JOIN DimSalesTerritory t ON t.SalesTerritoryKey = i.SalesTerritoryKey
	JOIN DimDate d ON i.OrderDateKey = d.DateKey

GROUP BY
	YEAR(d.FullDateAlternateKey),
	MONTH(d.FullDateAlternateKey),
	t.SalesTerritoryRegion,
	t.SalesTerritoryCountry,
	t.SalesTerritoryGroup
ORDER BY
    t.SalesTerritoryCountry,
    t.SalesTerritoryRegion,
    CYear,
    CMonth;

-- Calculate the average order size (in terms of both quantity and sales amount) for each combination of product category, 
-- product subcategory, and calendar quarter.
SELECT 
	AVG(OrderQuantity) AS AvgOrderQty,
	AVG(SalesAmount) AS AvgSalesAmt,
	pc.EnglishProductCategoryName,
	ps.EnglishProductSubcategoryName,
	DATEPART(QUARTER, d.FullDateAlternateKey) AS CalendarQuarter
FROM 
	FactInternetSales i
	JOIN DimDate d
	ON d.DateKey = i.OrderDateKey
	JOIN DimProduct p 
	ON p.ProductKey = i.ProductKey
	JOIN DimProductSubcategory ps
	ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey
	JOIN DimProductCategory pc
	ON ps.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY 
	pc.EnglishProductCategoryName,
	ps.EnglishProductSubcategoryName,
	DATEPART(QUARTER, d.FullDateAlternateKey)
ORDER BY 
	pc.EnglishProductCategoryName,
	ps.EnglishProductSubcategoryName,
	DATEPART(QUARTER, d.FullDateAlternateKey)

-- Find the sales representatives who have the highest and lowest average discounts offered to their customers, 
-- including their names and the respective average discount percentages.
SELECT TOP(1) 
	AVG(DiscountAmount) AS HighestAvgDiscount, 
	EmployeeKey
FROM FactResellerSales
GROUP BY EmployeeKey
ORDER BY AVG(DiscountAmount) DESC

SELECT TOP(1) 
	AVG(DiscountAmount) AS LowestAvgDiscount, 
	EmployeeKey
FROM FactResellerSales
GROUP BY EmployeeKey
ORDER BY AVG(DiscountAmount) 

