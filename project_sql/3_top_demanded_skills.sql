/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for a data engineer
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data%' AND
    job_title_short LIKE '%Engineer%' AND
    job_work_from_home = true
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5

/*
### Key insight

* **SQL (18,701)** and **Python (18,497)** form the **absolute foundation** of Data Engineering roles.
* The difference between them is marginal (~1.1%), meaning:

  * Employers almost universally expect **both**, not one or the other.

### Interpretation

This strongly suggests:

* Data Engineering is still **data-modeling and data-access centric**, not purely infrastructure-focused.
* Even for remote roles, companies prioritize engineers who can:

  * Design and query data models (SQL)
  * Orchestrate, transform, and automate pipelines (Python)

📌 **Implication**: Any candidate missing either SQL or Python is filtered out early.

Results for 'remote' and 'data engineer' job postings
[
  {
    "skills": "sql",
    "demand_count": "18701"
  },
  {
    "skills": "python",
    "demand_count": "18497"
  },
  {
    "skills": "aws",
    "demand_count": "11937"
  },
  {
    "skills": "azure",
    "demand_count": "9237"
  },
  {
    "skills": "spark",
    "demand_count": "9035"
  }
]
*/