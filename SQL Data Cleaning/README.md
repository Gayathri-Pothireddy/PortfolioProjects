# Nashville Housing Data Cleaning Project

## Overview

This project involves cleaning and enhancing the Nashville Housing Dataset. The SQL queries provided address various data quality issues, such as standardizing date formats, populating missing property addresses, breaking down address components, changing values for clarity, removing duplicates, and deleting unnecessary columns.

## Purpose

The primary objectives of this data cleaning project are to:

- Ensure data consistency by standardizing date formats.
- Improve data completeness by populating missing property addresses.
- Enhance data analysis capabilities by breaking down address components.
- Improve data readability by changing values in the "Sold as Vacant" field.
- Eliminate duplicate records to maintain data integrity.
- Optimize the dataset by removing unused columns.

## Data Cleaning Steps

### Standardize Date Format

Convert the `SaleDate` column to the `DATE` data type for consistency.

### Populate Property Address Data

Fill missing property addresses by leveraging similar records based on the `ParcelID`.

### Break Out Address Components

Separate the `PropertyAddress` column into individual columns (`PropertySplitAddress`, `PropertySplitCity`) for improved analysis.

### Change Y and N to Yes and No

Update values in the `SoldAsVacant` field for better readability.

### Remove Duplicates

Identify and remove duplicate records based on specific columns.

### Delete Unused Columns

Remove columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`) that are no longer necessary.




