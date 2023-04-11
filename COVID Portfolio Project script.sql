

Select *
From PortfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--Select *
--From PortfolioProject..CovidVaccinations
--order by 3,4

-- Select Data that we are going to be using

Select Location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
order by 1,2


-- Looking at Total Cases vs. Total Deaths

-- Shows the likelilhood of dying if you contract covid in your country
SELECT Location, date, CAST(total_cases AS bigint) totalcases, CAST(total_deaths AS bigint) totaldeaths,
(total_deaths / CAST(total_cases AS decimal(18,2)))*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%states%'
ORDER BY 1,2


--Looking at total cases vs population
-- Shows what precentage of population got covid
SELECT Location, date, population,total_cases,
(total_cases/population)*100 as PrecentagePopulaionInfected
FROM PortfolioProject..CovidDeaths
Where location like '%states%'
ORDER BY 1,2

-- Which country has th highest infenction rate compared to population

SELECT Location, population, MAX(total_cases) as HighestInfectionCount,
MAX((total_cases)/population)*100 as PrecentagePopulaionInfected
FROM PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by location, population
ORDER BY PrecentagePopulaionInfected desc


-- Showing countries with the highest death count per Population

SELECT Location, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
Group by location
ORDER BY TotalDeathCount desc

--LETS BREAK THINGS DOWN BY CONTINENT


--Showing Continent with the highest death count

SELECT continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
Group by continent
ORDER BY TotalDeathCount desc


-- GLOBAL NUMBERS
SELECT date, SUM(new_cases) as totalcases, SUM(cast(new_deaths as int)) as totaldeaths,
CASE
	WHEN SUM(new_cases) = 0 THEN NULL
	ELSE SUM(cast(new_deaths as decimal(18,2))) / SUM(new_cases) * 100
END as DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population) *100
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	on dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
order by 2,3



--USE CTE

With PopvsVac (Continent, location, date, population,new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population) *100
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	on dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/population) *100
from PopvsVac



-- TEMP TABLE

DROP Table if exists #PrecentPopulationVaccinated
Create table #PrecentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PrecentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population) *100
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	on dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3

Select *, (RollingPeopleVaccinated/population) *100
from #PrecentPopulationVaccinated


-- Creating view to store data for later visualizations

Create View PrecentPeopleVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population) *100
From PortfolioProject..CovidVaccinations vac
Join PortfolioProject..CovidDeaths dea
	on dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--order by 2,3

CREATE VIEW CountriesDeathCount AS
SELECT continent, MAX(CAST(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
Where continent is not null
Group by continent







Select *
From PrecentPeopleVaccinated