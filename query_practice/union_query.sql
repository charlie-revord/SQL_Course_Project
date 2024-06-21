-- CTE subquery that compiles first quarter jobs

WITH first_quarter_jobs AS (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT * 
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
)
-- Main query to return jobs above 70k in first quarter with skills
SELECT 
    first_quarter_jobs.job_id, 
    first_quarter_jobs.job_title_short, 
    first_quarter_jobs.job_location,
    first_quarter_jobs.job_via,
    skills_dim.skills,
    skills_dim.type
FROM first_quarter_jobs
LEFT JOIN skills_job_dim ON first_quarter_jobs.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE salary_year_avg > 70000
ORDER BY first_quarter_jobs.job_id ASC;