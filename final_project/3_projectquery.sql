-- Query 3: Average rounded salary for top 10 US companies
SELECT 
    company_dim.company_id,
    company_dim.name AS company_name,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short ILIKE '%Data_Analyst%' AND
    job_country = 'United States'
GROUP BY company_dim.company_id, company_dim.name
ORDER BY 
    COUNT(job_postings_fact.job_id) DESC, 
    average_salary DESC
LIMIT 10;
