# Indian-Startup-Funding-Analysis-2020-2025-

## Project Objective
To analyze the Indian startup funding ecosystem from 2020 to 2025 by identifying funding trends, investment patterns, top-performing industries, leading investors, and startup performance. The project leverages PostgreSQL for data cleaning and analysis and Power BI for building an interactive dashboard that transforms raw funding data into actionable business insights for investors, analysts, and decision-makers.

## Tech Stack
The dashboard was built using the following tools and technologies:<br>
• 🐘 PostgreSQL – Database used for data storage, cleaning, transformation, and SQL analysis.<br>
• 📝 SQL – Used for data querying, aggregation, window functions, CTEs, ranking, and business analysis.<br>
•	📊 Power BI Desktop – Main data visualization platform used for report creation.<br>
•	📂 Power Query – Data transformation and cleaning layer for reshaping and preparing the data.<br>
•	🧠 DAX (Data Analysis Expressions) – Used for calculated measures, dynamic visuals, and conditional logic.<br>
• 📄 CSV Dataset – Source data containing Indian startup funding records (2020–2025).<br>
• 📁 File Formats – .pbix for dashboard development, .sql for SQL analysis, .csv for the dataset, and .png for dashboard previews.<br>
• 🐙 Git & GitHub – Used for version control, project documentation, and portfolio hosting.<br>

## Data Source
- <a href="https://www.kaggle.com/datasets/vagdevititikshag/indian-startup-funding-dataset-20202025">Indian Startup Funding Dataset (2020–2025)</a>

## Project Workflow

Here’s a step-by-step breakdown of what we do in this project:

### 1. Database & Table Creation
We start by creating a SQL table with appropriate data types:

```sql
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
```

### 2. Data Import
- Loaded CSV using pgAdmin's import feature.

- Faced encoding issues (UTF-8 error), which were fixed by saving the CSV file using CSV UTF-8 format.

### 3. Data Cleaning & Validation
- Counted the total number of records in the dataset.
- Validated the dataset by checking for missing values, duplicates, and data type inconsistencies.
- Used Common Table Expressions (CTEs) for temporary data transformations without modifying the original dataset.
- Standardized inconsistent startup names to ensure accurate analysis.
- Processed investor names for participation analysis using SQL and Power Query.

### 4. Data Exploration
Performed exploratory data analysis (EDA) using SQL to understand funding patterns and investment trends, including:
- Funding trends over the years
- Top funded industries and startups
- Geographic distribution of funding across cities
- Investment stage analysis
- Investor participation analysis
- Subvertical performance analysis

### 5. Business Questions
- How has startup funding changed from 2020 to 2025?
- Which industries and startups attracted the highest funding?
- Which cities emerged as major startup funding hubs?
- Which investors participated in the highest number of deals?
- How do investment stages compare in terms of deal volume and average funding?
- Which subverticals received the highest investments?

### 6. Dashboard Development
- Imported the dataset into Power BI.
- Performed transformations to clean few inconsistencies in startup and investors column using Power Query.
- Created DAX measures for KPIs and analytical calculations.
- Designed a two-page interactive dashboard to visualize funding trends, investment patterns, investor activity, and startup performance.

## Dashboard Walkthrough
### Page 1 – Executive Overview

#### 💰 KPI Cards
- Total Funding Raised
- Total Investment Deals
- Total Startups
- Total Industries
- Top Funded Industry

#### 📈 Funding Trend by Year
Displays the annual funding trend from 2020 to 2025, helping identify periods of growth, decline, and recovery in startup investments.

#### 🏭 Top Funded Industries
Ranks industries based on total funding received, highlighting the sectors that attracted the highest investment.

#### 🌍 Funding Distribution by City
Visualizes funding across major Indian startup hubs, allowing easy comparison of regional investment activity.


#### 🚀 Top Funded Startups
Displays the startups that secured the highest total funding during the analysis period.

### Page 2 – Detailed Analysis

#### 💵 Investment Type Analysis
A combo chart comparing:
- Number of investment deals
- Average funding amount

This helps understand how funding size changes across different investment stages.

#### 🤝 Top Active Investors
Ranks investors based on their participation across funding rounds, identifying the most active investors in the ecosystem.

#### 📍 Industry Positioning
A scatter plot comparing industries by:
- Total Deal Count
- Average Funding

This visualization helps distinguish industries with high investment activity from those receiving larger average investments per deal.
