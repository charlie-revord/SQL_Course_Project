-- Opening CTE for top 10 analyst companies in US
WITH top_US_companies AS (
    SELECT 
        company_dim.company_id,
        company_dim.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short ILIKE '%Data_Analyst%' AND
        job_country = 'United States'
    GROUP BY company_dim.company_id, company_dim.name
    ORDER BY COUNT(job_postings_fact.job_id) DESC
    LIMIT 10
)

-- Query 2: What is the distribution of top company jobs by WFH policy?
SELECT 
    top_US_companies.company_name,
    job_postings_fact.job_work_from_home,
    COUNT(job_postings_fact.job_id) AS job_count
FROM top_US_companies
LEFT JOIN job_postings_fact ON top_US_companies.company_id = job_postings_fact.company_id
WHERE 
        job_title_short ILIKE '%Data_Analyst%' AND
        job_country = 'United States'
GROUP BY top_US_companies.company_name, job_work_from_home
ORDER BY company_name ASC, job_count DESC;