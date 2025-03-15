SELECT *
from layoffs_stagging;

 
SELECT company, MAX(total_laid_off)
FROM layoffs_stagging
group by company
order by MAX(total_laid_off) DESC


SELECT  MAX(percentage_laid_off), MAX(total_laid_off)
FROM layoffs_stagging

 SELECT *
 from layoffs_stagging
 where percentage_laid_off =1
 order by funds_raised_millions DESC

SELECT company , SUM(total_laid_off) AS Total_people
from layoffs_stagging
GROUP BY company
ORDER BY SUM(total_laid_off) DESC

SELECT MIN([date]), MAX([date])
from layoffs_stagging

SELECT country , SUM(total_laid_off) AS Total_people
from layoffs_stagging
GROUP BY country
ORDER BY SUM(total_laid_off) DESC

SELECT YEAR([date]), SUM(total_laid_off)
from layoffs_stagging
group by YEAR([date])
order by 1 DESC

SELECT MONTH([date]), SUM(total_laid_off)
FROM layoffs_stagging
WHERE MONTH([date]) IS NOT NULL
GROUP BY MONTH([date])
ORDER BY 1

SELECT 
    LEFT([date], 7) AS [Month], 
    SUM(total_laid_off) AS total_laid_off
FROM layoffs_stagging
WHERE [date] IS NOT NULL
GROUP BY LEFT([date], 7)
ORDER BY [Month];


-- Rolling Monthly sum
WITH Rolling_Tot AS (
    SELECT 
        LEFT([date], 7) AS [Month], 
        SUM(total_laid_off) AS total_laid_off
    FROM layoffs_stagging
    WHERE [date] IS NOT NULL
    GROUP BY LEFT([date], 7)
)
SELECT [Month], total_laid_off, SUM(total_laid_off) OVER(ORDER BY [Month])
FROM Rolling_Tot
ORDER BY [Month];
