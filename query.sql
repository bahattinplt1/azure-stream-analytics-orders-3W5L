SELECT
    DateAdd(second,-10,System.TimeStamp) AS StartTime,
    System.TimeStamp AS EndTime,
    ProductID,
    SUM(Quantity) AS Orders
INTO
    [blobstore]
FROM
    [orders] TIMESTAMP BY EventProcessedUtcTime
GROUP BY ProductID, TumblingWindow(second, 10)
HAVING COUNT(*) > 1