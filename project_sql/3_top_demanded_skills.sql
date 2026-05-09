/*
----------------------------------------------------
Question:
What are the most in-demand skills for Data Analyst roles?

Approach:
- Extract Data Analyst job postings
- Link each job to its required skills using skill mapping tables
- Count how often each skill appears across all postings
- Rank skills by frequency of occurrence

Key filter:
- Data Analyst roles only
- Remote jobs only
----------------------------------------------------
*/

SELECT
    s.skills,
    COUNT(*) AS demand_count
FROM job_postings_fact j
INNER JOIN skills_job_dim sj 
    ON j.job_id = sj.job_id
INNER JOIN skills_dim s 
    ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.job_location = 'Anywhere'
GROUP BY
    s.skills
ORDER BY
    demand_count DESC
LIMIT 5;