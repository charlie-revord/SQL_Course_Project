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

-- Query 4: What are the top demanded skills for analyst jobs within the top 10 companies?
SELECT 
    skills_dim.skills,
    COUNT(skills_dim.skill_id) AS skill_count
FROM 
    top_US_companies
INNER JOIN job_postings_fact ON top_US_companies.company_id = job_postings_fact.company_id
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short ILIKE '%Data_Analyst%' AND
        job_country = 'United States'
GROUP BY skills_dim.skills
ORDER BY skill_count DESC
LIMIT 15;