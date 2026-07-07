-- Location Incident Analysis

   Business question:
   Which countries have the highest incident pressure within each market,
   and what is the most common incident type in each location?
    */


WITH location_orders AS (
    SELECT
        l.Market,
        l.Region,
        l.Country,
        COUNT(DISTINCT o.OrderID) AS TotalOrders
    FROM dbo.fact_orders AS o
    INNER JOIN dbo.dim_location AS l
        ON o.LocationID = l.LocationID
    GROUP BY
        l.Market,
        l.Region,
        l.Country
    HAVING
        COUNT(DISTINCT o.OrderID) >= 10
),


location_incidents AS (
    SELECT
        l.Market,
        l.Region,
        l.Country,
        COUNT(DISTINCT i.OrderID) AS OrdersWithIncidents, 
        AVG(CAST(DATEDIFF(DAY, i.IncidentDate, i.ResolutionDate) AS decimal(10,2))) AS AvgResolutionDays
    FROM dbo.incidents AS i
    INNER JOIN dbo.fact_orders AS o
        ON i.OrderID = o.OrderID
    INNER JOIN dbo.dim_location AS l
        ON o.LocationID = l.LocationID
    GROUP BY
        l.Market,
        l.Region,
        l.Country

),


incident_type_ranking AS (
    SELECT
        x.Market,
        x.Region,
        x.Country,
        x.IncidentType,
        x.IncidentTypeCount,
        ROW_NUMBER() OVER(PARTITION BY x.Market,x.Region,x.Country ORDER BY x.IncidentTypeCount DESC, x.IncidentType ASC) AS RowNumber

    FROM (
        SELECT
            l.Market,
            l.Region,
            l.Country,
            i.IncidentType,
            COUNT(DISTINCT i.IncidentID) AS IncidentTypeCount
        FROM dbo.incidents AS i
        INNER JOIN dbo.fact_orders AS o
            ON i.OrderID = o.OrderID
        INNER JOIN dbo.dim_location AS l
            ON o.LocationID = l.LocationID
        GROUP BY
            l.Market,
            l.Region,
            l.Country,
            i.IncidentType
    ) AS x
)

SELECT
    lo.Market,
    lo.Region,
    lo.Country,
    lo.TotalOrders,
    li.OrdersWithIncidents,
    CONCAT(CAST(li.OrdersWithIncidents * 100.0 / lo.TotalOrders AS decimal(10,2)), '%') AS IncidentOrderRatePct,
    li.AvgResolutionDays, 
    itr.IncidentType AS MostFrequentIncidentType,
    itr.IncidentTypeCount AS MostFrequentIncidentTypeCount,
    RANK() OVER(PARTITION BY lo.Market ORDER BY li.OrdersWithIncidents * 100.0 / lo.TotalOrders DESC) AS IncidentRiskRankInMarket
FROM location_orders AS lo
INNER JOIN location_incidents AS li
    ON lo.Market = li.Market
    AND lo.Region = li.Region
    AND lo.Country = li.Country

INNER JOIN incident_type_ranking AS itr
    ON lo.Market = itr.Market
    AND lo.Region = itr.Region
    AND lo.Country = itr.Country
    AND itr.RowNumber = 1
ORDER BY
    lo.Market,
    IncidentRiskRankInMarket;