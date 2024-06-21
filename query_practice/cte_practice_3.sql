--CTE 1: Unique skills count by Company
WITH company_skills_count AS (
    SELECT
        job_postings_fact.company_id,
        COUNT(DISTINCT skills_job_dim.skill_id) AS skills_count
    FROM job_postings_fact
    LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    GROUP BY job_postings_fact.company_id
),

--CTE 2: Highest Average Salary by Company with Skills
company_top_salary AS (
    SELECT 
        company_id,
        MAX(salary_year_avg) AS company_max
    FROM job_postings_fact
    WHERE job_postings_fact.job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY company_id
)

--Main query: Return Companies by their skill count requirement and max salary for skilled jobs
SELECT
    company_dim.name,
    company_skills_count.skills_count,
    CASE
        WHEN skills_count > 0 THEN 'Skills Needed'
        ELSE 'Zero Skills Needed'
    END AS skill_requirement,
    company_top_salary.company_max
FROM company_dim
LEFT JOIN company_skills_count ON company_dim.company_id = company_skills_count.company_id
LEFT JOIN company_top_salary ON company_dim.company_id = company_top_salary.company_id
ORDER BY company_dim.name;
