/*
----------------------------------------------------
Question:
What are the top 10 highest-paying remote Data Analyst jobs with a listed salary?

Key filters:
- Data Analyst roles only
- Remote jobs only
- Valid salary data
----------------------------------------------------
*/

SELECT
    j.job_id,
    j.job_title,
    j.job_location,
    j.job_schedule_type,
    j.salary_year_avg,
    j.job_posted_date,
    c.name AS company_name
FROM job_postings_fact j
LEFT JOIN company_dim c
    ON j.company_id = c.company_id
WHERE 
    j.job_title_short = 'Data Analyst'
    AND j.job_location = 'Anywhere'
    AND j.salary_year_avg IS NOT NULL
ORDER BY 
    j.salary_year_avg DESC
LIMIT 10;