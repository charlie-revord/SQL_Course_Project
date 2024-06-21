-- subquery to create table of country average salary
WITH country_salary_average AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS country_average
    FROM job_postings_fact
    GROUP BY job_country
)
-- main query to compare all jobs with salary against their country's average
SELECT 
    company_dim.name,
    job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_country,
    salary_year_avg,
    country_average,
    CASE
        WHEN salary_year_avg > country_average THEN 'Above Average'
        WHEN salary_year_avg < country_average THEN 'Below Average'
    END AS salary_rating,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS posted_month,
    EXTRACT(YEAR FROM job_postings_fact.job_posted_date) AS posted_year
FROM job_postings_fact
INNER JOIN country_salary_average ON job_postings_fact.job_country = country_salary_average.job_country
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE salary_year_avg IS NOT NULL
ORDER BY posted_year DESC, posted_month DESC;
