UPDATE StockCardsToUpdate SET LastSaleDate = TransactionSaleDates.SaleDate
FROM StockCards AS StockCardsToUpdate
INNER JOIN
	(SELECT LastSaleDate, LastSaleCollection.ProductId, LastSaleCollection.SaleDate FROM StockCards
	INNER JOIN 
		(SELECT MAX(EntryDate) As SaleDate, ProductId FROM TransactionItems WHERE Type = 0 AND StockPointId = 2 GROUP BY ProductId)
		LastSaleCollection ON LastSaleCollection.ProductId = StockCards.OriginatingId
		WHERE StockPointId = 2 AND LastSaleDate < LastSaleCollection.SaleDate) 
TransactionSaleDates ON TransactionSaleDates.ProductId = StockCardsToUpdate.OriginatingId
