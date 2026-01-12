/*
Question: What are the top paying data engineer jobs?
- Identify the top 10 highest-paying Data Engineer roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-paying opportunities for Data Engineers, offering insights into empl

- Additionally, show the companies that offer these top-paying job for Data Engineer roles.
*/

SELECT
    job_postings.job_id,
    job_postings.job_title,
    companies.name AS company_name,
    job_postings.job_location,
    job_postings.job_schedule_type,
    job_postings.salary_year_avg,
    job_postings.job_posted_date
FROM
    job_postings_fact AS job_postings
LEFT JOIN company_dim AS companies ON job_postings.company_id = companies.company_id
WHERE
    job_title_short LIKE '%Data%' AND
    job_title_short LIKE '%Engineer%' AND
    (job_location = 'Anywhere' OR job_location = 'Argentina') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10