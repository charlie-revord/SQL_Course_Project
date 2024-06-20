SELECT company_dim.name, COUNT(job_postings.job_id) AS job_count
FROM job_postings_fact AS job_postings
INNER JOIN company_dim ON job_postings.company_id = company_dim.company_id
WHERE EXTRACT(QUARTER FROM job_postings.job_posted_date) = 2 AND EXTRACT(YEAR FROM job_postings.job_posted_date) = '2023' AND job_postings.job_health_insurance = true
GROUP BY company_dim.name
HAVING COUNT(job_id) >= 1
ORDER BY job_count DESC;