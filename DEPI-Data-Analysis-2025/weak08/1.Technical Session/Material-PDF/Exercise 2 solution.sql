SELECT 
    s.ContactName,
    COUNT(o.OrderID) AS total_orders,
    SUM(od.Quantity) AS total_items_ordered
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
JOIN OrderDetails od ON p.ProductID = od.ProductID
JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '2016-01-01' AND '2016-12-31'  -- Date filter for orders
GROUP BY s.ContactName
HAVING COUNT(o.OrderID) > 10  -- Only suppliers with more than 10 orders
ORDER BY total_orders DESC;


