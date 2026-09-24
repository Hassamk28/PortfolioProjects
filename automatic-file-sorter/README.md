# Automatic File Sorter

**Notebook:** [automatic_file_sorter.ipynb](automatic_file_sorter.ipynb)
**Tools:** Python (`os`, `shutil`)

## The goal
Clean up a cluttered Downloads folder automatically.

## What it does
- Creates sub-folders for **Excel, CSV, executable, and image** files if they
  don't already exist.
- Moves each file into the matching folder based on its extension
  (`.xlsx`, `.csv`, `.exe`, `.jpg`, `.png`).
- Skips files already in the destination, so it is safe to run again and again.

## Skills shown
File-system automation and writing scripts that are safe to re-run.
