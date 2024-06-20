SELECT EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS posted_month, COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date) = '2023'
GROUP BY posted_month
ORDER BY posted_month ASC;

--Quick Change