-- CREATE DATABASE PortfolioProject2;
-- SELECT *
-- FROM layoffs;

-- SELECT * INTO layoffs_stagging
-- from layoffs;

--  Will check for the Null 
SELECT *
FROM layoffs_stagging
WHERE funds_raised_millions = 'NULL'

-- Will convert them to the Null for converting it to the INT or change the datatype for calculations
UPDATE layoffs_stagging
SET funds_raised_millions = NULL
WHERE funds_raised_millions = 'Null'


ALTER TABLE layoffs_stagging
ALTER COLUMN funds_raised_millions FLOAT


SELECT company, MAX(funds_raised_millions)
FROM layoffs_stagging
GROUP BY company
order by MAX(funds_raised_millions) DESC


-- Will check for the duplicate values using the CTEs and Row_Number() 
WITH duplicarte_CTEs AS
(
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, [location], industry, total_laid_off, 
        percentage_laid_off, stage, country, funds_raised_millions, [date]
        ORDER BY (SELECT NULL)  -- ORDER BY clause is mandatory
    ) AS row_num
FROM layoffs_stagging
)
SELECT *
from duplicarte_CTEs
WHERE row_num >1 
-- Alternate Query if we do not want to use the CTEs

SELECT *
FROM (SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, [location], industry, total_laid_off, 
        percentage_laid_off, stage, country, funds_raised_millions, [date]
        ORDER BY (SELECT NULL)  -- ORDER BY clause is mandatory
    ) AS row_num
FROM layoffs_stagging
)t 
where row_num >1

-- Now will check if the values that we got are really duplicates
SELECT *
FROM layoffs_stagging
where company = 'Casper'

-- Now will delete all the values which are duplicates
WITH duplicarte_CTEs AS
(
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY company, [location], industry, total_laid_off, 
        percentage_laid_off, stage, country, funds_raised_millions, [date]
        ORDER BY (SELECT NULL)  -- ORDER BY clause is mandatory
    ) AS row_num
FROM layoffs_stagging
)
DELETE
from duplicarte_CTEs
WHERE row_num >1 

-- Will trim the space for standardizing the data
SELECT company, TRIM(company)
from layoffs_stagging

SELECT *
FROM layoffs_stagging
-- WHERE company LIKE ' %';  
WHERE LEFT(company,1) = ' ';

SELECT industry, count(industry) 
from layoffs_stagging
WHERE industry like 'Crypto%'
GROUP By industry
ORDER BY industry

UPDATE layoffs_stagging 
SET industry = 'Crypto'
WHERE industry like 'Crypto%'

-- Now will look for the country
SELECT DISTINCT [country]
FROM layoffs_stagging
order by 1

SELECT country, count(country) 
from layoffs_stagging
WHERE country like 'United S%'
GROUP By country
ORDER BY country

UPDATE layoffs_stagging
SET country = 'United States'
WHERE country like 'United S%'

-- now will see for a date col.
SELECT *
FROM layoffs_stagging
where [date] = 'Null'

UPDATE layoffs_stagging
SET [date] = Null
where [date] = 'Null'

SELECT [date],
CONVERT(DATE, [date],101)
FROM layoffs_stagging

ALTER TABLE layoffs_stagging
ALTER COLUMN [date] DATE
