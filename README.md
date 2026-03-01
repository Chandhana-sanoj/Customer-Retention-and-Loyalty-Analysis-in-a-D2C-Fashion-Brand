# Customer Retention and Loyalty Analysis – D2C Fashion Brand
**Tools:** Python | SQL Server | Power BI

## Project Overview
This project analyzes customer retention and loyalty patterns for a simulated D2C fashion brand 
operating across multiple cities, sales channels, and campaign types over an 18-month period.
The objective was to identify which customer behaviors predict long-term value and how campaigns 
and channels influence repeat purchases.

## Business Questions
**Retention:**
- What percentage of customers return?
- How long does it take for a customer to make their next purchase?

**Segmentation:**
- Which customer segments generate the most revenue?
- How are customers distributed across behavioral groups?

**Campaign Impact:**
- Which campaign types generate the highest revenue?
- Which campaigns attract repeat customers?

**Omnichannel Behavior:**
- Do customers who interact with both store and online channels show stronger engagement?

**Time Trends:**
- How do orders, customers, and revenue change month by month?

## Dataset
- 10,000 customers | 21,000+ orders | 18 months (July 2024 – December 2025)
- Generated using Python to simulate realistic D2C retail patterns
- Includes seasonal spikes (Onam, Christmas), omnichannel behavior, and campaign types

## Dashboard Preview
![Dashboard Preview](dashboard/Dashboard_Screenshot.png)

## Key Insights
1. 54.2% repeat purchase rate with an average repeat gap of 129 days
2. Organic campaigns drive the highest revenue (₹34.1M)
3. Online channel contributes ~65% of total revenue
4. 70% of customers are single-channel — omnichannel opportunity exists
5. New/Low Activity segment is the largest — conversion is the key growth lever

## Recommendations
1. Deploy reactivation campaigns at 90–110 days to reduce repeat gap
2. Incentivize cross-channel purchases to convert single-channel customers
3. Introduce targeted offers for New/Low Activity segment
4. Increase marketing spend pre-festival to capitalize on seasonal peaks
5. Shift campaign focus from acquisition to lifecycle value

## Project Workflow
**1. Data Generation (Python)**
- Generated realistic synthetic dataset with skewed order distribution
- Added seasonal demand patterns and campaign/channel biases

**2. Data Cleaning & Governance (SQL Server)**
- Standardized city names and handled NULL values
- Validated row counts, date ranges, and foreign key integrity

**3. Analysis (SQL Server)**
- Customer segmentation using RFM logic
- Campaign performance and omnichannel behavior analysis
- Monthly trend analysis

**4. Visualization (Power BI)**
- Built interactive dashboard with KPIs, slicers, and charts
- Focused on decision-ready metrics, not vanity metrics

## Repository Structure
project-root/
├── data/
├── sql/
├── dashboard/
├── docs/
└── README.md

## Skills Demonstrated
- Synthetic data generation with realistic business patterns (Python)
- Data cleaning and governance (SQL Server)
- RFM-based customer segmentation
- Business KPI design and dashboard creation (Power BI)
- Translating business questions into actionable insights

