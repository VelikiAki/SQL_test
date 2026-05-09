/*
----------------------------------------------------
Question:
What are the most optimal skills for Data Analysts
based on both demand and average salary?

Approach:
- Calculate how frequently each skill appears in Data Analyst job postings
- Compute the average salary associated with each skill
- Combine demand and salary metrics to identify valuable skills

Key filters:
- Data Analyst roles only
- Remote jobs only
- Valid salary data
----------------------------------------------------
*/
WITH skills_demand AS (
    SELECT
        s.skill_id,
        s.skills,
        COUNT(*) AS demand_count
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
        s.skill_id, s.skills
),

average_salary AS (
    SELECT
        s.skill_id,
        s.skills,
        ROUND(AVG(j.salary_year_avg),0) AS avg_salary
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
        s.skill_id, s.skills
)

SELECT
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    asl.avg_salary
FROM skills_demand sd
INNER JOIN average_salary asl
    ON sd.skill_id = asl.skill_id
WHERE
    sd.demand_count>10
ORDER BY
    asl.avg_salary DESC,
    sd.demand_count DESC
LIMIT 25;