SELECT SUM(TotalProductCost),  OrderMonth, OrderYear
FROM (SELECT TotalProductCost, DATEPART(MONTH, OrderDate) AS OrderMonth, DATEPART(YEAR, OrderDate) AS OrderYear
		FROM FactInternetSales)
		AS InternetMonthAmount
GROUP BY OrderMonth, OrderYear
ORDER BY OrderYear, OrderMonth