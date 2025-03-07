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
-- Alternate Query if we do not want to use the CTEs
SELECT *
from duplicarte_CTEs
WHERE row_num >1 

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



