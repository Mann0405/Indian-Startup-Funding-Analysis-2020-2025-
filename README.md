# Indian-Startup-Funding-Analysis-2020-2025-

## Project Objective
To analyze the Indian startup funding ecosystem from 2020 to 2025 by identifying funding trends, investment patterns, top-performing industries, leading investors, and startup performance. The project leverages PostgreSQL for data cleaning and analysis and Power BI for building an interactive dashboard that transforms raw funding data into actionable business insights for investors, analysts, and decision-makers.

## Tech Stack
The dashboard was built using the following tools and technologies:<br>
• 🐘 PostgreSQL – Database used for data storage, cleaning, transformation, and SQL analysis.<br>
• 📝 SQL – Used for data querying, aggregation, window functions, CTEs, ranking, and business analysis.<br>
• 📊 Power BI Desktop – Main data visualization platform used for report creation.<br>
• 📂 Power Query – Data transformation and cleaning layer for reshaping and preparing the data.<br>
• 🧠 DAX (Data Analysis Expressions) – Used for calculated measures, dynamic visuals, and conditional logic.<br>
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
💰 **KPI Cards**
- **Total Funding**: $28.09 Billion total funding was raised by Indian startups between 2020 and 2025
- **Total Deals**: A total of 1,100 investment deals were recorded during the analysis period.
- **Total Startups**: The dataset contains funding information for 130 unique startups.
- **Total Industries**: Funding activity spans across 14 different industries.
- **Top Funded Industry**: FoodTech emerged as the highest-funded industry during the analysis period.

📈 **Funding Trend by Year**: The line chart shows the yearly funding trend from 2020 to 2025.

🌍 **Funding Distribution by City**: The map displays the geographical distribution of startup funding across major Indian cities.

🚀 **Top Funded Startups**: The column chart ranks top 5 startups by total funding raised.

🏭 **Top Funded Industries**: The bar chart shows top 5 industries based on total funding received.

### Page 2 – Detailed Analysis

💵 **Investment Type Analysis**: The combo chart compares the total number of investment deals with the average funding amount across different investment types.

🤝 **Most Active Investors**: The bar chart ranks investors based on their participation in funding rounds.

📍 **Industry Positioning: Deals vs Average Funding**: A scatter plot comparing industries by total number of deals (X-axis) and average funding per deal (Y-axis).

## 💡 Key Insights

- Indian startups attracted **$28.09 Billion** in funding through **1,100 investment deals** between **2020 and 2025**, reflecting strong investment activity in the startup ecosystem.

- Funding peaked in **2021 ($6.02B)**, declined during **2022–2023**, and rebounded in **2024 ($5.98B)**, indicating fluctuations in investor sentiment and market conditions. It was lower in 2025 due to partial-year data.

- **FoodTech** emerged as the highest-funded industry with **$3.48 Billion**, followed by **Consumer Electronics ($2.70B)** and **Retail ($2.67B)**, highlighting strong investor preference for consumer-focused sectors.

- Subvertical analysis revealed that investors preferred specialized business models within industries. **EV (Mobility)**, **Fashion (Retail)**, **Cloud Kitchen (FoodTech)**, **Content (Media)**, and **Wearables (Consumer Electronics)** received the highest funding within their respective industries.

- Startup analysis showed that **NextSense** raised the highest funding (**$1.00B**), followed by **HomeFoods**, **Unacademy**, **CoreSpace**, and **NeoSense**, indicating that funding was concentrated among a small number of high-growth startups.

- Funding was concentrated in major startup hubs such as **Pune, Kolkata, Delhi, Gurugram, Chennai, and Bengaluru**, emphasizing the importance of established startup ecosystems in attracting capital.

- **Seed** funding recorded the highest number of deals, demonstrating strong investor confidence in early-stage startups, while **Growth** and **Private Equity** rounds had the highest average funding per deal, reflecting larger capital requirements at later stages.

- 🤝 **Tiger Global** emerged as the most active investor, participating in **140 funding deals**, significantly ahead of **Y Combinator (84)** and **Mirae Asset (83)**. This highlights Tiger Global's strong and consistent involvement in India's startup funding ecosystem.

- Industry positioning analysis showed that high deal volume does not always correspond to high average funding, indicating differences in capital intensity and investment strategies across industries.

- The combination of SQL analysis and Power BI dashboards transformed raw funding data into actionable insights, enabling easy identification of investment trends, high-performing sectors, active investors, and emerging startup opportunities.

## Dashboard
### 1. Executive Overview Page

<img width="1000" height="900" src="https://github.com/Mann0405/Indian-Startup-Funding-Analysis-2020-2025-/blob/main/Snapshot%20of%20Executive%20Overview%20Page.PNG" />

### 2. Detailed Analysis Page

<img width="1000" height="900" src="https://github.com/Mann0405/Indian-Startup-Funding-Analysis-2020-2025-/blob/main/Snapshot%20of%20Detailed%20Analysis%20Page.PNG" />
