WITH security_info AS(
  SELECT
    ticker,
    company_name,
    exchange,
    type,
    sector,
    industry,
    market,
    currency
  FROM
    `equity-warehouse-511410.price_warehouse.dim_security`
),
security_snapshot AS(
  SELECT
    ticker,
    market_cap,
    avg_volume,
    shares_outstanding,
    dividend_yield,
    beta,
    pe,
    forward_pe,
    eps,
    forward_eps,
    peg_ratio
  FROM
    `equity-warehouse-511410.price_warehouse.fact_security_snapshot`
)
SELECT
  si.ticker,
  CAST(CURRENT_TIMESTAMP() AS DATE) AS as_of_date,
  si.company_name,
  si.exchange,
  si.type,
  si.sector,
  si.industry,
  si.market,
  si.currency,
  ss.market_cap,
  ss.avg_volume,
  ss.shares_outstanding,
  ss.dividend_yield,
  ss.beta,
  ss.pe,
  ss.forward_pe,
  ss.eps,
  ss.forward_eps,
  ss.peg_ratio
FROM 
  security_info AS si
LEFT JOIN security_snapshot AS ss
  ON ss.ticker = si.ticker;