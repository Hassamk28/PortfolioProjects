# Nashville Housing Data Cleaning (SQL)

**Script:** [nashville_housing_cleaning.sql](nashville_housing_cleaning.sql)
**Tools:** Microsoft SQL Server (T-SQL)

## The goal
Turn a raw Nashville real-estate sales dataset into a clean table that is ready
for analysis.

## Cleaning steps
1. **Standardized sale dates**: converted datetime values to plain dates.
2. **Filled missing property addresses**: used a **self-join** on `ParcelID`
   to copy the address from another sale of the same parcel.
3. **Split addresses into columns**:
   - Property address → street / city, using `SUBSTRING` + `CHARINDEX`
   - Owner address → street / city / state, using `PARSENAME(REPLACE(...))`
4. **Made the "Sold as Vacant" field consistent**: mapped `Y`/`N` to
   `Yes`/`No` with `CASE`.
5. **Removed duplicates** using a CTE with `ROW_NUMBER() OVER (PARTITION BY …)`
   across parcel, address, price, date, and legal reference.
6. **Dropped unused columns** after splitting them out.

## Skills shown
Self-joins, string functions, `CASE` logic, window functions for
de-duplication, and `ALTER`/`UPDATE` to change the table.
