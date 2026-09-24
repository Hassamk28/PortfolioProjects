# Amazon Price Tracker

**Notebook:** [amazon_price_tracker.ipynb](amazon_price_tracker.ipynb)
**Tools:** BeautifulSoup, requests, csv, pandas, datetime

## The goal
Track a product's price over time automatically, without checking the page by
hand. The example product is a PlayStation 5 controller.

## What I did
1. Requested the product page with browser-style headers and parsed it with
   **BeautifulSoup** to pull the **title** and **current price**.
2. Cleaned the extracted text and stamped each reading with **today's date**.
3. Wrote the results to a **CSV** with headers, then **appended** a new row on
   every run so the file becomes a price history.
4. Wrapped everything in a `price_check()` function and put it in a loop, so it
   runs on its own in the background at a set interval.

## Skills shown
Web scraping, HTML parsing, building a dataset over time, and simple task
automation.

> Note: Amazon's page layout changes often, so the HTML selectors may need
> updating before this runs today.
