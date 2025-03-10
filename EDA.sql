SELECT *
from layoffs_stagging;

SELECT company, MAX(total_laid_off)
FROM layoffs_stagging
GROUP BY company
order by MAX(total_laid_off) ASC

SELECT company, MAX(total_laid_off)
FROM layoffs_stagging
group by company
order by MAX(total_laid_off) DESC


SELECT  MAX(percentage_laid_off), MAX(total_laid_off)
FROM layoffs_stagging

