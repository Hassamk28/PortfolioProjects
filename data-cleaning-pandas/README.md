# Data Cleaning in pandas

**Notebook:** [data_cleaning_pandas.ipynb](data_cleaning_pandas.ipynb)
**Tools:** pandas

## The goal
Take a messy customer call list and turn it into a clean list a call team
could actually use. Every number on it should be callable, and nobody who asked
not to be contacted should be on it.

## What I did
- Removed **duplicate rows** and a column that held no useful data.
- Stripped stray characters (`123._/`) from last names.
- Standardized **phone numbers** from mixed formats into `123-456-7890`, and
  cleared out invalid entries.
- **Split the address** into street, state, and ZIP columns.
- Standardized Yes/No fields (`Paying Customer`, `Do_Not_Contact`) to `Y` / `N`.
- **Removed customers marked Do Not Contact** and rows with no phone number.
- Reset the index so the result is ready to export.

## Skills shown
String cleaning, regex replacement, column splitting, handling missing values,
and applying business rules as row filters.
