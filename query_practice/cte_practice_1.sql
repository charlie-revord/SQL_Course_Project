WITH distinct_company_jobs AS (
    SELECT 
        company_id,
        COUNT(DISTINCT job_title) AS unique_job_count
    FROM job_postings_fact
    GROUP BY company_id
    ORDER BY unique_job_count DESC
)
SELECT 
    company_dim.company_id, 
    company_dim.name, 
    distinct_company_jobs.unique_job_count
FROM distinct_company_jobs
INNER JOIN company_dim ON distinct_company_jobs.company_id = company_dim.company_id
ORDER BY unique_job_count DESC
LIMIT 10;