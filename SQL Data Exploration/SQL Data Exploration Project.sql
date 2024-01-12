-- https://ourworldindata.org/covid-deaths

SELECT *
FROM [Project-1].dbo.CovidDeaths
WHERE continent is NOT NULL
ORDER BY location, date

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [Project-1].dbo.CovidDeaths
ORDER BY location, date

-- Total Cases vs Total Deaths
-- (Likelihood of death in case of COVID contraction)

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM [Project-1].dbo.CovidDeaths
WHERE location like 'United States'
ORDER BY location, date

-- Total Cases vs Population
-- (percentage of population contracted COVID)

SELECT location, date, population, total_cases, (total_cases/population)*100 AS percentge_of_population_infected
FROM [Project-1].dbo.CovidDeaths
WHERE location like 'United States'
ORDER BY location, date

-- Countries with Highest Infection Rate compared to Population

SELECT location, population, MAX(total_cases) AS highest_contraction_count, MAX(total_cases/population)*100 AS percentge_of_population_infected
FROM [Project-1].dbo.CovidDeaths
GROUP BY location, population
ORDER BY percentge_of_population_infected DESC

-- Countries with Highest Death Count per Population

SELECT location, MAX(total_deaths) AS total_death_count
FROM [Project-1].dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY location
ORDER BY total_death_count DESC

-- Maximum Death Count per Population by Continent

SELECT continent, MAX(total_deaths) AS total_death_count
FROM [Project-1].dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC

-- Global Numbers: death percentage by date

SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM [Project-1].dbo.CovidDeaths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY date,total_cases

-- Total number of Cases, Deaths and Death percentage globally

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths)/SUM(new_cases))*100 AS death_percentage
FROM [Project-1].dbo.CovidDeaths
WHERE continent is NOT NULL

-- Total Populations vs Vaccinations by date

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM [Project-1].dbo.CovidDeaths dea
JOIN [Project-1].dbo.CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent is NOT NULL
ORDER BY location, date

-- Rolling count of vaccinated people by location and date

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_count_of_vaccinated_people 
FROM [Project-1].dbo.CovidDeaths dea
JOIN [Project-1].dbo.CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent is NOT NULL
ORDER BY location, date

-- -- Using CTE to perform Calculation on Partition By in previous query

WITH PopvsVac (continent, location, date, population, new_vaccinations, rolling_count_of_vaccinated_people)
AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_count_of_vaccinated_people 
FROM [Project-1].dbo.CovidDeaths dea
JOIN [Project-1].dbo.CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent is NOT NULL
)
SELECT *, (rolling_count_of_vaccinated_people/population)*100 percentage_of_total_people_vaccinated
FROM PopvsVac

-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #percent_population_vaccinated
CREATE TABLE #percent_population_vaccinated (
   continent NVARCHAR(255), 
   location NVARCHAR(255), 
   date DATETIME, 
   population NUMERIC, 
   new_vaccinations NUMERIC, 
   rolling_count_of_vaccinated_people NUMERIC
)
INSERT INTO #percent_population_vaccinated 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_count_of_vaccinated_people 
FROM [Project-1].dbo.CovidDeaths dea
JOIN [Project-1].dbo.CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date


SELECT *, (rolling_count_of_vaccinated_people/population)*100 percentage_of_total_people_vaccinated
FROM #percent_population_vaccinated

-- Creating View to store data for visualizations on tableau

CREATE VIEW percentage_of_total_people_vaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS rolling_count_of_vaccinated_people 
FROM [Project-1].dbo.CovidDeaths dea
JOIN [Project-1].dbo.CovidVaccinations vac
    ON dea.location = vac.location 
    AND dea.date = vac.date
WHERE dea.continent is NOT NULL

SELECT * 
FROM percentage_of_total_people_vaccinated