-- Importing Data
USE startup_funding_database;

DROP TABLE IF EXISTS startup_funding;

CREATE TABLE startup_funding (
    funding_id SERIAL PRIMARY KEY,
    startup VARCHAR(255),
    industry VARCHAR(100),
    subvertical VARCHAR(150),
    city VARCHAR(100),
    investors TEXT,
    investmenttype VARCHAR(50),
    investmentamount_usd BIGINT,
    funding_date DATE);

SELECT * 
FROM startup_funding 
LIMIT 10;

-- ============================================================
-- DATA CLEANING & VALIDATION
-- ============================================================

-- Check Total Records

SELECT
    COUNT(*)
FROM startup_funding;

-- Check Data Types

SELECT 
	column_name, 
	data_type 
FROM information_schema.columns
WHERE table_name = 'startup_funding';

-- Check NULL Values

SELECT *
FROM startup_funding
WHERE startup IS NULL
	OR industry IS NULL 
	OR subvertical IS NULL 
	OR city IS NULL 
	OR investors IS NULL 
	OR investmenttype IS NULL 
	OR investmentamount_usd IS NULL 
	OR funding_date IS NULL;

-- Check Duplicate Records

SELECT 
	startup, industry, subvertical, city, investors, investmenttype, investmentamount_usd, funding_date,
    COUNT(*) AS duplicate_count
FROM startup_funding
GROUP BY 
	startup, industry, subvertical,city, investors, investmenttype, investmentamount_usd, funding_date
HAVING COUNT(*) > 1;

-- ============================================================
-- EXPLORATORY DATA ANALYSIS
-- ============================================================

SELECT 
	DISTINCT city 
FROM startup_funding 
ORDER BY city;

SELECT 
	DISTINCT industry 
FROM startup_funding 
ORDER BY industry;

SELECT 
	MIN(investmentamount_usd) AS minimum_funding, 
	MAX(investmentamount_usd) AS maximum_funding,
    AVG(investmentamount_usd) AS average_funding 
FROM startup_funding;

SELECT 
	MIN(funding_date) AS first_funding, 
	MAX(funding_date) AS latest_funding 
FROM startup_funding;

-- Funding trend by year
SELECT 
	EXTRACT(YEAR FROM funding_date) AS year, 
	COUNT(*) AS total_deals
FROM startup_funding 
GROUP BY year 
ORDER BY year;

-- Year-wise total funding
SELECT 
	EXTRACT(YEAR FROM funding_date) AS year,
    ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM startup_funding 
GROUP BY year 
ORDER BY year;

-- Number of deals by Industry
SELECT 
	industry, 
	COUNT(*) AS total_deals 
FROM startup_funding 
GROUP BY industry 
ORDER BY total_deals DESC;

-- Total funding by Industry
SELECT 
	industry, 
	ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM startup_funding 
GROUP BY industry 
ORDER BY SUM(investmentamount_usd) DESC;

-- Average funding by Industry
SELECT
    industry, COUNT(*) AS total_deals,
    ROUND(AVG(investmentamount_usd) / 1000000.0, 2) AS avg_funding_million_usd
FROM startup_funding 
GROUP BY industry 
ORDER BY avg_funding_million_usd DESC;

-- Top cities by total funding
SELECT 
	city, 
	ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM startup_funding 
GROUP BY city 
ORDER BY total_funding_million_usd DESC;

-- Investor participation frequency
WITH split_investors AS (
    SELECT
        TRIM(UNNEST(STRING_TO_ARRAY(investors, ','))) AS investor
    FROM startup_funding
),
clean_investors AS (
    SELECT 
		CASE WHEN investor = 'Tiger Global Management' THEN 'Tiger Global' 
			ELSE investor 
			END AS investor
    FROM split_investors)
SELECT 
	investor, 
	COUNT(*) AS participation_count 
FROM clean_investors
GROUP BY investor 
ORDER BY participation_count DESC;

-- Deal Count by Investment Type
SELECT 
	investmenttype, 
	COUNT(*) AS total_deals 
FROM startup_funding
GROUP BY investmenttype 
ORDER BY total_deals DESC;

-- Total funding by Investment Type
SELECT 
	investmenttype, 
	ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM startup_funding 
GROUP BY investmenttype 
ORDER BY total_funding_million_usd DESC;

-- Average funding by Investment Type
SELECT 
	investmenttype, 
	ROUND(AVG(investmentamount_usd) / 1000000.0, 2) AS avg_funding_million_usd
FROM startup_funding 
GROUP BY investmenttype 
ORDER BY avg_funding_million_usd DESC;

-- Check for startup inconsistencies
SELECT 
	DISTINCT startup 
FROM startup_funding 
ORDER BY startup;


-- Top startups by total funding
WITH clean_startups AS (
    SELECT
        SPLIT_PART(startup, '_', 1) AS startup,
        investmentamount_usd
    FROM startup_funding
)SELECT 
	startup, 
	ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM clean_startups 
GROUP BY startup 
ORDER BY total_funding_million_usd DESC 
LIMIT 10;

-- Funding stage progression
WITH clean_startups AS (
    SELECT
        SPLIT_PART(startup, '_', 1) AS startup,
        investmenttype
    FROM startup_funding
),
stage_order AS (
    SELECT 
		DISTINCT startup, 
		investmenttype, 
		CASE investmenttype 
			WHEN 'Pre-Seed' THEN 1  
			WHEN 'Seed' THEN 2 
			WHEN 'Pre-Series A' THEN 3  
			WHEN 'Series A' THEN 4 
			WHEN 'Series B' THEN 5  
			WHEN 'Series C' THEN 6
			WHEN 'Series D' THEN 7 
			END AS stage_no 
	FROM clean_startups 
	WHERE investmenttype IN (
		'Pre-Seed', 
		'Seed', 
		'Pre-Series A', 
		'Series A', 
		'Series B', 
		'Series C', 
		'Series D')
)
SELECT 
	startup, 
	COUNT(*) AS stages_reached, 
	STRING_AGG(investmenttype, ' → ' ORDER BY stage_no) AS stage_progression
FROM stage_order 
GROUP BY startup 
ORDER BY stages_reached DESC, startup;

-- Top Subverticals by Total Funding
WITH clean_startups AS (
    SELECT
        SPLIT_PART(startup, '_', 1) AS startup,
        industry,
        subvertical,
        city,
        investors,
        investmenttype,
        investmentamount_usd,
        funding_date
    FROM startup_funding
)
SELECT
    subvertical,
    ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
FROM startup_funding
GROUP BY subvertical
ORDER BY total_funding_million_usd DESC
LIMIT 10;

-- Top subvertical within each industry
WITH subvertical_funding AS (
    SELECT
        industry,
        subvertical,
        ROUND(SUM(investmentamount_usd) / 1000000.0, 2) AS total_funding_million_usd
    FROM startup_funding
    GROUP BY
        industry,
        subvertical
),
ranked_subverticals AS (
    SELECT
        industry,
        subvertical,
        total_funding_million_usd,
        RANK() OVER (
            PARTITION BY industry
            ORDER BY total_funding_million_usd DESC
        ) AS funding_rank
    FROM subvertical_funding
)
SELECT
    industry,
    subvertical,
    total_funding_million_usd
FROM ranked_subverticals
WHERE funding_rank = 1
ORDER BY total_funding_million_usd DESC;