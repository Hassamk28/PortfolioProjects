# Product Catalog Web Scraper

**Notebook:** [product_web_scraper.ipynb](product_web_scraper.ipynb) ·
**Output:** [product_data.csv](product_data.csv)
**Tools:** BeautifulSoup, requests, pandas

## The goal
Build a structured product list (name, price, image, and SKU) from an
online auto-parts catalog that spreads its products across many pages.

## What I did
- Looped through **multiple catalog pages** by building each page's URL
  (64 products per page).
- Parsed each page with **BeautifulSoup** to pull the product name, price, and
  image link.
- Used `try`/`except` handling so a missing field doesn't stop the whole run.
- Loaded the results into a **pandas DataFrame** and exported them to
  [`product_data.csv`](product_data.csv).

## Skills shown
Scraping across paginated pages, building a dataset from HTML, error handling,
and exporting to CSV.
