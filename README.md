# 🚚 Delivery Logistics Performance & Operations Analysis

## 🎯 Business Problem

The logistics operation handled a large number of deliveries but needed a clearer
understanding of delivery delays, delivery partners, service modes, weather
conditions, delivery costs, customer ratings and overall operational performance.

## 🔍 What I Did

- Cleaned and prepared 25,000 delivery records using Python/Pandas
- Checked missing values, duplicates and data quality
- Corrected and standardized delivery IDs
- Converted delivery time fields into usable numeric hour values
- Created delivery time difference information for performance analysis
- Analyzed delivery partners, delivery modes, regions, weather conditions,
  vehicle types and package types using PostgreSQL
- Answered 15 business questions using SQL
- Built an interactive 3-page Power BI dashboard

## 💡 Key Findings

- 25,000 delivery records were analyzed.
- The overall delivery delay rate was 26.68%.
- The overall average delivery time was 6.25 hours.
- The average delivery cost was ₹864.94.
- The average customer rating was 3.7/5.
- The failed delivery rate was 5.31%.
- XpressBees had the highest delay rate among delivery partners at 28.27%.
- Delhivery had the lowest delay rate among delivery partners at 24.80%.
- Stormy weather had the highest delay rate at 41.4%, followed by rainy weather at 37.4%.
- Standard deliveries had a 100% delivered outcome in the dataset.
- Two-day deliveries had a 99.57% delivered outcome.
- Delivery partner performance varied across reliability, delivery speed,
  customer ratings and delivery cost.

## 💡 Business Suggestions

- Review delivery partners with relatively high delay rates and high delivery volumes.
- Investigate operational challenges during stormy and rainy weather conditions.
- Monitor delivery modes with higher delayed and failed delivery proportions.
- Compare delivery partners based on reliability, speed, customer satisfaction and cost.
- Prioritize operational improvements where high delivery volume and high delay rates overlap.
- Continue monitoring customer ratings alongside operational performance metrics.

## 🛠️ Skills Used

Python | Pandas | NumPy | PostgreSQL | SQL | Power BI | DAX | Data Cleaning | EDA | Data Analysis | Data Visualization

## 📂 Project Files

- [Python Data Cleaning & Analysis](3.Delivery_Logistics_Analysis/delivery_logistics_datacleaning.ipynb)
- [SQL Business Analysis](3.Delivery_Logistics_Analysis/delivery_logistics_analysis.sql)
- [Power BI Dashboard](3.Delivery_Logistics_Analysis/Delivery_Logistics_Dashboard.pbix)

## 📊 Dashboard

![Logistics Operations Overview](3.Delivery_Logistics_Analysis/images/page1.png)

![Delivery Performance](3.Delivery_Logistics_Analysis/images/page2.png)

![Delivery Partner Performance](3.Delivery_Logistics_Analysis/images/page3.png)
