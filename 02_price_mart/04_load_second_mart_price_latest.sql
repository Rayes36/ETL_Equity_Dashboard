SELECT
  fpd.ticker,
  fpd.date,
  fpd.close,
  dd.week_start
FROM
  `equity-warehouse-511410.price_warehouse.fact_price_daily` AS fpd
LEFT JOIN `equity-warehouse-511410.price_warehouse.dim_date` AS dd
  ON dd.date = fpd.date
ORDER BY
  ticker,
  date;