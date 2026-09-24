# COVID-19 Data Exploration (SQL)

**Script:** [covid_data_exploration.sql](covid_data_exploration.sql)
**Tools:** Microsoft SQL Server (T-SQL)

## The goal
Explore global COVID-19 case, death, and vaccination data to answer questions
about infection rates, death rates, and vaccine rollout. The data is the public
COVID-19 dataset from Our World in Data, split into a `CovidDeaths` table and a
`CovidVaccinations` table.

## Questions explored
- How likely was death after catching COVID in the United States, over time?
- What share of each country's population was infected?
- Which countries had the **highest infection rate** compared to population?
- Which countries and continents had the **highest death counts**?
- What were the **global** daily case and death totals, and the death rate?
- How did **vaccinations build up** in each country as a share of population?

## SQL techniques used
| Technique | Where |
|---|---|
| `JOIN` across two tables | Deaths joined to vaccinations on location + date |
| Window function `SUM() OVER (PARTITION BY … ORDER BY …)` | Running total of people vaccinated per country |
| CTE (`WITH … AS`) | Calculating the vaccinated % from the running total |
| Temp table | Same calculation, stored for re-use |
| `CAST` and safe division with `CASE` | Avoiding integer division and divide-by-zero |
| `CREATE VIEW` | Saved results for use in Tableau/Power BI |
