-- Query 1: What are the top 10 hiring firms for Data Analysts in the US? 

SELECT 
    company_dim.company_id, 
    company_dim.name, 
    COUNT(job_postings_fact.job_id) AS job_count
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short ILIKE '%Data_Analyst%' AND
    job_country = 'United States'
GROUP BY company_dim.company_id, company_dim.name
ORDER BY job_count DESC
LIMIT 10;
