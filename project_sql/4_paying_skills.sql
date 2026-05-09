/*
----------------------------------------------------
Question:
Which skills are associated with the highest average salaries for Data Analyst roles?

Approach:
- Filter job postings for Data Analyst roles with available salary data
- Join job postings with skill mapping tables
- Calculate the average salary for each skill
- Rank skills by highest average salary

Key filters:
- Data Analyst roles only
- Remote jobs only
- Only jobs with valid salary information
----------------------------------------------------
*/

SELECT
    s.skills,
    ROUND(AVG(salary_year_avg),0) AS average_salary
FROM job_postings_fact j
INNER JOIN skills_job_dim sj
    ON j.job_id = sj.job_id
INNER JOIN skills_dim s
    ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
    AND j.job_location = 'Anywhere'
GROUP BY 
    s.skills
ORDER BY
    average_salary DESC
LIMIT 25;