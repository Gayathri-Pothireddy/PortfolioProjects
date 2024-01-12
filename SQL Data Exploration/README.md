# COVID-19 Data Analysis SQL Queries

## Overview

This project comprises SQL queries for analyzing COVID-19 data sourced from [Our World in Data](https://ourworldindata.org/covid-deaths). The SQL queries cover a range of analyses, including total cases vs total deaths, percentage of population infected, countries with the highest infection rates, death counts per population, global numbers, and vaccination statistics. The queries aim to provide insights into the impact of COVID-19 on different regions globally.

## Data Source

The COVID-19 data used in these queries is obtained from [Our World in Data](https://ourworldindata.org/covid-deaths). The dataset is organized into two tables: `CovidDeaths` and `CovidVaccinations`.

## SQL Queries

1. **General Data Retrieval:**
   - Retrieve relevant columns from the `CovidDeaths` table for analysis.

2. **Total Cases vs Total Deaths:**
   - Analyze the likelihood of death in case of COVID contraction.

3. **Total Cases vs Population:**
   - Analyze the percentage of the population that contracted COVID.

4. **Global Analysis:**
   - Identify countries with the highest infection rates and death counts per population. Explore the maximum death count per population by continent.

5. **Global Numbers:**
   - Analyze global numbers, including total cases, total deaths, and death percentage by date. Also, explore the total number of cases, deaths, and death percentage globally.

6. **Vaccination Analysis:**
   - Analyze total populations vs vaccinations by date. Investigate the rolling count of vaccinated people by location and date. Utilize temporary tables and views for advanced calculations and Tableau visualizations.
