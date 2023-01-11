mysql

USE QuantigrationUpdates;

SELECT State, COUNT(OrderID), COUNT(RMAID)
FROM(
SELECT Collaborators.State AS State, RMA.RMAID AS RMAID, Orders.OrderID AS OrderID
FROM Collaborators
JOIN Orders
ON Orders.CollaboratorID = Collaborators.CollaboratorID
JOIN RMA
ON Orders.OrderID = RMA.OrderID
WHERE RMA.Status = 'Complete') AS t1
GROUP BY State;

SELECT SKU AS PRODUCT_SKU, Description AS PRODUCT_DESCRIPTION,
(COUNT(*) * 100 / (SELECT COUNT(*)
FROM Orders INNER JOIN RMA ON Orders.OrderID = RMA.OrderID WHERE Status = 'Complete')) AS RETURN_PERCENTAGE
FROM Orders INNER JOIN RMA ON Orders.OrderID = RMA.OrderID
WHERE Status='Complete'
GROUP BY PRODUCT_SKU
ORDER BY RETURN_PERCENTAGE;
