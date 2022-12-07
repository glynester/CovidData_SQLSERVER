-- Start from https://www.youtube.com/watch?v=QILNlRvJlfQ&list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f&index=3

-- Creating view to store data for later visualisations
--CREATE VIEW PercentPopulationVaccinated AS 
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--from [dbo].[CovidDeaths] dea JOIN [dbo].[CovidVaccinations] vac ON 
--dea.location = vac.location
--AND dea.date =  vac.date
--WHERE dea.continent IS NOT Null
----ORDER BY 2,3

--SELECT * FROM PercentPopulationVaccinated 

-- Looking at total population vs vaccinations
-- Using a Temp Table

--DROP TABLE IF EXISTS #PercentPopulationVaccinated
--CREATE TABLE #PercentPopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar(255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--INSERT INTO #PercentPopulationVaccinated
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--from [dbo].[CovidDeaths] dea JOIN [dbo].[CovidVaccinations] vac ON 
--dea.location = vac.location
--AND dea.date =  vac.date
--WHERE dea.continent IS NOT Null
----ORDER BY 2,3

--SELECT *,(RollingPeopleVaccinated/population)*100 
--FROM #PercentPopulationVaccinated


-- Looking at total population vs vaccinations
-- Using a CTE

--WITH PopvsVac (Continent, Location, Date, Population, new_vaccinations, RollingPeopleVaccinated)
--AS
--(
--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--from [dbo].[CovidDeaths] dea JOIN [dbo].[CovidVaccinations] vac ON 
--dea.location = vac.location
--AND dea.date =  vac.date
--WHERE dea.continent IS NOT Null
----ORDER BY 2,3
--)
--SELECT *,(RollingPeopleVaccinated/population)*100 
--FROM PopvsVac

-- Looking at total population vs vaccinations

--SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
--SUM(CONVERT(int, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
----,(RollingPeopleVaccinated/population)*100
--from [dbo].[CovidDeaths] dea JOIN [dbo].[CovidVaccinations] vac ON 
--dea.location = vac.location
--AND dea.date =  vac.date
--WHERE dea.continent IS NOT Null
--ORDER BY 2,3


-- Global numbers
--SELECT TOP(1000) /*[date],*/ SUM(new_cases)  AS total_cases, sum(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
--FROM [dbo].[CovidDeaths]
--WHERE continent IS NOT Null
----GROUP BY date
--ORDER BY 1,2


-- Deaths by continent- howing highest death count by continent

--SELECT TOP(1000)[location], MAX(CAST(total_deaths AS int)) AS TotalDeathCount
--FROM [dbo].[CovidDeaths]
--WHERE continent IS Null
--GROUP BY location 
--ORDER BY TotalDeathCount DESC

-- people who died - showing highest death count per population
--SELECT TOP(1000)[Location], MAX(CAST(total_deaths AS int)) AS TotalDeathCount
--FROM [dbo].[CovidDeaths]
----WHERE location NOT IN (
----'World','Europe','North America','European Union','South America','Africa','Asia')
--WHERE continent IS NOT Null
--GROUP BY location 
--ORDER BY TotalDeathCount DESC


----Countries with highest infection rate
--SELECT TOP(1000)[location], [population],MAX([total_cases]) AS HighestInfectionCount,  MAX(total_cases/population)*100 AS PercentPopulationInfected
--FROM [dbo].[CovidDeaths]
----WHERE location LIKE '%states%'
--GROUP BY location,population 
--ORDER BY PercentPopulationInfected DESC

----Total cases vs population - shows what % have gotten covid
--SELECT TOP(1000)[location], [date], [population],[total_cases],  (total_cases/population)*100 AS PercentPopulationInfected
--FROM [dbo].[CovidDeaths]
--WHERE [location] LIKE '%states%'
--ORDER BY 1,2

----Deaths vs Cases - likelihood of dying if you get covid in your country
--SELECT TOP(1000)[location], [date], [total_cases], [total_deaths], (total_deaths/total_cases)*100 AS DeathPercentage
--FROM [dbo].[CovidDeaths]
--WHERE LOCATION LIKE '%states%'
--ORDER BY 1,2

--SELECT TOP(100)[location], [date], [total_cases], [new_cases],[total_deaths],[population]
--FROM [dbo].[CovidDeaths]
--ORDER BY 1,2

--SELECT TOP(100) * FROM [dbo].[CovidDeaths]
--ORDER BY 3,4

--SELECT TOP(100) * FROM [dbo].[CovidVaccinations]
--ORDER BY 3,4