SELECT company_dim.name
FROM company_dim
INNER JOIN (
-- Subquery 1: Calculate average salary by company
    SELECT 
        company_id,
        AVG(salary_year_avg) AS company_average
    FROM job_postings_fact
    GROUP BY company_id
) AS company_avg_salaries ON company_dim.company_id = company_avg_salaries.company_id
WHERE company_avg_salaries.company_average > (
-- Subquery 2: Calculate average salary across all jobs   
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
)
ORDER BY company_dim.name ASC;

--TEST
