/*
----------------------------------------------------
Question:
What skills are required for the top 10 highest-paying remote Data Analyst jobs?

Approach:
- First, identify the top 10 highest-paying remote Data Analyst job postings
- Then, map each job to its required skills using relational skill tables
- Finally, extract and display the associated skills for these high-paying roles

Key filters:
- Data Analyst roles only
- Remote jobs only
- Valid salary data
----------------------------------------------------
*/

WITH top_paying_jobs AS (
    SELECT 
        j.job_id,
        j.job_title,
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
)

SELECT 
    tpj.job_id,
    tpj.job_title,
    tpj.company_name,
    tpj.salary_year_avg,
    tpj.job_posted_date,
    s.skills
FROM top_paying_jobs tpj
INNER JOIN skills_job_dim sj
    ON tpj.job_id = sj.job_id
INNER JOIN skills_dim s
    ON sj.skill_id = s.skill_id
ORDER BY 
    tpj.salary_year_avg DESC;