CREATE DATABASE covid19;

EXEC sp_help 'covid_death';

SELECT TOP 5 *
FROM covid_death;


SELECT *
FROM covid_death;

/*Write a query to list the location, date, total cases, new cases, total death, 
and population, ordered by location and date.*/
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM   covid_death
ORDER BY 1, 2;


/* write a query to calculate the percentage of death of each county */
SELECT  location, 
	    total_cases, 
	    total_deaths,
CASE
	WHEN	total_cases = 0 
	THEN	null
	ELSE	(total_deaths/total_cases)*100
END AS	death_rate
FROM	covid_death; 


/* write a query to calculate the percentage of death of China */

SELECT  location, 
	    total_cases, 
	    total_deaths,
CASE
	WHEN	total_cases = 0 
	THEN	null
	ELSE	(total_deaths/total_cases)*100
END AS	death_rate
FROM	covid_death
WHERE location = 'China';


/* Write a query to display the percentage of postive covid cases of US */
SELECT  location, 
		date, 
		total_cases, 
		population, 
		(total_cases/population)*100 postive_rate
FROM covid_death
WHERE location like '%states%'
ORDER BY 1,2;


/* Write a query to show the highest infection rate*/
SELECT  location,  
		MAX(total_cases) hightest_postive_case,
		population, 
		MAX(total_cases/population)*100 max_postive_rate
FROM covid_death
GROUP BY location, population
ORDER BY max_postive_rate DESC;


/* Write a query to conculate total number of death from covid world wide*/

SELECT location, MAX(total_deaths) max_death
FROM covid_death
WHERE location = 'World'
GROUP BY location;


/* Write a query to conculate total number of death from covid by continent*/

SELECT continent, MAX(total_deaths) max_death
FROM covid_death
WHERE continent NOT IN ('')
GROUP BY continent;


/* Write a query to conculate the death rate from covid*/
SELECT 
	location, 
	SUM(total_deaths), 
	SUM(total_cases), 
CASE 
	WHEN SUM(total_cases) = 0 THEN NULL
	ELSE (SUM(total_deaths)/SUM(total_cases))*100
END AS deaths_rate 
FROM covid_death
GROUP BY location
ORDER BY deaths_rate DESC;


/*Write a query to conculate the new cases and new deaths on daily baise */
SELECT date, SUM(new_cases), SUM(new_deaths)
FROM covid_death
GROUP BY date
ORDER BY 1;


/*Write a query to conculate the new deaths rate all over the world.*/
SELECT
	SUM(new_deaths) total_new_deaths, 
	SUM(new_cases) total_new_cases, 
	SUM(new_deaths)/SUM(new_cases)*100 new_deaths_rate
FROM covid_death;


