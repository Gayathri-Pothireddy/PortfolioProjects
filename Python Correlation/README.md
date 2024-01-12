# Movie Correlation Project in Python

## Overview

The Movie Correlation Project is a Python script that analyzes a movie dataset, exploring correlations between various features such as budget, gross earnings, ratings, and more. The dataset used in this project is sourced from Kaggle and contains information about movies, including their release year, genre, ratings, and financial performance.

## Purpose

The primary goal of this project is to uncover insights into the relationships between different movie attributes. By visualizing and analyzing correlations, the script aims to provide a better understanding of how factors like budget, ratings, and release year influence a movie's success, as measured by gross earnings.

## How to Use

1. **Download the Dataset:**
   - Download the movie dataset from [Kaggle](https://www.kaggle.com/danielgrijalvas/movies) and save it as `movies.csv'.

2. **Run the Script:**
   - Open the Python script in a Python environment.
   - Ensure that you have the required libraries installed (pandas, numpy, seaborn, and matplotlib).
   - Execute the script to load, clean, and analyze the movie dataset.

3. **Explore Correlations:**
   - The script generates visualizations, such as scatter plots and correlation matrices, to highlight relationships between different movie features.
   - Investigate the top movie companies by gross revenue and explore their impact on the industry.

## Data Cleaning

The script performs basic data cleaning, handling missing values, and correcting data types for columns like `budget` and `gross`. It also creates a `year_correct` column to address inconsistencies in the `released` and `year` columns.

## Visualizations

The project includes various visualizations, such as scatter plots and correlation matrices, to illustrate relationships between numeric features. These visualizations provide a comprehensive overview of the dataset.

## Top Movie Companies

The script identifies and displays the top 15 movie companies based on gross revenue, offering insights into the industry's major players.

## Contributing

Contributions to enhance the functionality, add new features, or address any issues are welcome. If you have ideas for improvements, please open an issue or submit a pull request following the standard Git workflow.
