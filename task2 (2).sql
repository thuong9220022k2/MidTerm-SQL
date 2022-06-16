with 
task2_1 as
	(select DATEPART(YEAR, OrderDate) AS OrderYear, 
			CustomerKey
	FROM FactInternetSales),
task2_2 as
	(SELECT  OrderYear as "1stPurchaseYear", 
			Count(DISTINCT CustomerKey) as NoNewCustomer 
	FROM task2_1
	GROUP BY OrderYear),
task2_3 as
	(SELECT  count(CustomerKey) as sosanh,  CustomerKey , min(OrderYear) as orderyear
	FROM task2_1
	GROUP BY CustomerKey
	having count(CustomerKey) > 1),
task2_4 as
	(select count(CustomerKey) as NoRetainCustomer , orderyear as "1stPurchaseYear"
	from task2_3
	GROUP BY orderyear)

select task2_2."1stPurchaseYear", NoNewCustomer, NoRetainCustomer, CAST(NoNewCustomer as float(1)) / CAST(NoRetainCustomer as float(1)) * 100 as PercentRetainCustomer
from task2_4
join task2_2 on task2_2.[1stPurchaseYear] = task2_4.[1stPurchaseYear]
order by task2_2."1stPurchaseYear"