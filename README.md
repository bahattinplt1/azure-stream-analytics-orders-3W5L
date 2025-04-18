# Azure Stream Analytics: Real-time Sales Order Processing

This project demonstrates how to process real-time sales transaction data using **Azure Stream Analytics**, **Event Hubs**, and **Blob Storage**.

It simulates order data from a client app, processes that data in 10-second windows using Stream Analytics, and stores the aggregated results in Azure Blob Storage.

---

## 📦 Components Used

- **Azure Event Hubs** – To simulate real-time order events
- **Azure Stream Analytics Job** – To query and aggregate incoming data
- **Azure Blob Storage** – To store the processed output as JSON

---

## 🔄 Stream Analytics Query

> `query.sql` file contains the full query used in this project.

```sql
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
