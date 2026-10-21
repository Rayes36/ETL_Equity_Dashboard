DROP TABLE IF EXISTS `equity-warehouse-511410.price_warehouse.fact_security_snapshot`;
DROP TABLE IF EXISTS `equity-warehouse-511410.price_warehouse.fact_price_daily`;
DROP TABLE IF EXISTS `equity-warehouse-511410.price_warehouse.dim_date`;
DROP TABLE IF EXISTS `equity-warehouse-511410.price_warehouse.dim_security`;

CREATE TABLE IF NOT EXISTS `equity-warehouse-511410.price_warehouse.dim_security`(
  ticker STRING,
  company_name STRING,
  exchange STRING,
  type STRING,
  sector STRING,
  industry STRING,
  market STRING,
  currency STRING,
  PRIMARY KEY (ticker) NOT ENFORCED
);

CREATE TABLE IF NOT EXISTS `equity-warehouse-511410.price_warehouse.dim_date`(
  date DATE,
  year INT64,
  quarter INT64,
  month INT64,
  week_start DATE,
  PRIMARY KEY (date) NOT ENFORCED
);

CREATE TABLE IF NOT EXISTS `equity-warehouse-511410.price_warehouse.fact_price_daily`(
  ticker STRING,
  date DATE,
  open FLOAT64,
  high FLOAT64,
  low FLOAT64,
  close FLOAT64,
  adj_close FLOAT64,
  volume INT64,
  dividends FLOAT64,
  stock_splits FLOAT64,
  PRIMARY KEY (ticker, date) NOT ENFORCED,
  FOREIGN KEY (ticker) REFERENCES `equity-warehouse-511410.price_warehouse.dim_security` (ticker) NOT ENFORCED,
  FOREIGN KEY (date) REFERENCES `equity-warehouse-511410.price_warehouse.dim_date` (date) NOT ENFORCED
);

CREATE TABLE IF NOT EXISTS `equity-warehouse-511410.price_warehouse.fact_security_snapshot`(
  ticker STRING,
  snapshot_date DATE,
  market_cap INT64,
  dividend_yield FLOAT64,
  volume INT64,
  avg_volume INT64,
  beta FLOAT64,
  pe FLOAT64,
  forward_pe FLOAT64,
  eps FLOAT64,
  forward_eps FLOAT64,
  peg_ratio FLOAT64,
  shares_outstanding INT64,
  PRIMARY KEY (ticker, snapshot_date) NOT ENFORCED,
  FOREIGN KEY (ticker) REFERENCES `equity-warehouse-511410.price_warehouse.dim_security` (ticker) NOT ENFORCED,
  FOREIGN KEY (snapshot_date) REFERENCES `equity-warehouse-511410.price_warehouse.dim_date` (date) NOT ENFORCED
);