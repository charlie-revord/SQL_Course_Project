# Introduction

In this document, I will go over an analysis I did as part of Luke Barousse's SQL course. 

The course is accessible here: [Luke Barousse SQL Course](https://www.lukebarousse.com/sql)

This analysis project showcases my mastery of SQL query-writing, Markdown, and managing Github Repositories.

# Background

In this project, my objective was to identify trends among the top 10 firms that are hiring Data Analysts within the United States. I organized this analysis into 5 queries:

1. What are the top 10 businesses located in the U.S. hiring Data Analysts by the number of jobs posted?
2. What is the distribution of Work From Home (WFH) jobs versus In-person jobs among these 10 firms by job count?
3. What is the average salary for Data Analyst roles by Top 10 company?  
4. What are the top 15 demanded skills by total count of mentions across jobs posted by the Top 10 businesses?
5. Finally, are the top demanded skills different by experience level (Junior/Entry, Lead/Manager, Senior, and Unspecified)?

The job dataset provided for this project originates from Luke Barousse's datanerd.tech app, which helps budding data professionals identify the most in-demand skills by data profession. 

More info about the source data can be accessed here: [datanerd.tech](https://datanerd.tech/About)

# Tools Used

* 📁 PostgreSQL: Open-source SQL database management software (RDBMS) used to store project data and run SQL queries

* ⌨️ VSCode: Used for writing and saving project SQL queries

* ☁️ Github: Cloud-based project storage and file management

* 📊 Tableau: Used for project query visualization outside of tablular results

# Analysis Process

## Query 1: Identifying the Top 10 U.S. Companies by jobs posted

```sql
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
```
### Results

![top 10 companies](assets/top10_us_analyst_companies.png)






