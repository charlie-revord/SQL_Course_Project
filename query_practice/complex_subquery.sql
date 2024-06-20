SELECT 
    company_dim.company_id,
    company_dim.name,
    CASE
        WHEN job_count < 10 THEN 'Small'
        WHEN job_count BETWEEN 10 AND 50 THEN 'Medium'
        WHEN job_count > 50 THEN 'Large'
    END AS company_size,
    job_count
FROM (
    SELECT company_id, 
    COUNT(job_id) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
) AS company_count
-- company_count is your left/initial table
INNER JOIN company_dim ON company_dim.company_id = company_count.company_id
GROUP BY company_dim.company_id, company_dim.name, job_count
ORDER BY job_count ASC;