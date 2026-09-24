# Sales Data Analysis (Python)

**Notebook:** [sales_analysis.ipynb](sales_analysis.ipynb)
**Tools:** pandas, matplotlib, itertools, collections

## The goal
Act like an analyst handed a folder of raw sales files and a list of stakeholder
questions. The data is a year (2019) of order-level sales for an electronics
retailer, split into 12 monthly CSV files.

## What I did
1. **Combined** the 12 monthly files into a single dataset.
2. **Cleaned** it: dropped blank rows, removed repeated header rows mixed into
   the data, and converted quantity and price columns to numbers.
3. **Added columns** for month, sales (quantity × price), city/state (parsed from
   the address), and order hour.
4. **Answered five business questions** with grouped summaries and charts.

## Key findings
| Question | Answer |
|---|---|
| Best month for sales? | **December**, about **$4.61M** in sales, the highest of the year. |
| City with the most sales? | **San Francisco, CA**, about **$8.26M**, well ahead of Los Angeles (~$5.45M). |
| When should ads run? | Orders peak around **11 AM and 7 PM**, so the recommendation is to advertise between those hours. |
| Products most often bought together? | **iPhone + Lightning Charging Cable** (1,005 orders), then **Google Phone + USB-C Cable** (987). Good candidates for bundles. |
| Best-selling product, and why? | Compared quantity sold against average price on a dual-axis chart. Low-cost accessories sell in the highest volumes. |

## Skills shown
Merging multiple files, data cleaning, feature engineering, `groupby`
aggregation, combination counting for market-basket analysis, and dual-axis
charts.
