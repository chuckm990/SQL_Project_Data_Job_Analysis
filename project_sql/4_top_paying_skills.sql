/*
Question: what are the top skills based on salary?
- Look at the average salary associated with each skill for Data Engineer positions.
- Focuses on roles with specified salaries, regarless of location.
- Why? It reveals how different skills impact salary levels for Data Engineers and
    helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_yearly_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data%' AND
    job_title_short LIKE '%Engineer%' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = true   --uncomment this for remote positions only
GROUP BY
    skills
ORDER BY
    average_yearly_salary DESC
LIMIT 25;
/*
### Top-paying Data Engineer roles in 2023 tend to:

* Be **senior or staff-level**
* Sit at the **intersection of data + systems + infra**
* Value **rare languages** and **architectural depth**
* Optimize for **performance, scale, or research**, not dashboards

### Market structure (simplified):

* **SQL/Python** → employability
* **Cloud + orchestration** → mid-level growth
* **Systems, niche DBs, low-level languages** → compensation ceiling

> **Demand skills get you hired. Scarce skills get you paid more.**

High-paying DE roles assume:

* You *already* know SQL, Python, cloud
* Salary is driven by what you bring **on top of the baseline**

Resulta from the query:
[
  {
    "skills": "assembly",
    "average_yearly_salary": "192500"
  },
  {
    "skills": "chef",
    "average_yearly_salary": "186500"
  },
  {
    "skills": "ggplot2",
    "average_yearly_salary": "176250"
  },
  {
    "skills": "rust",
    "average_yearly_salary": "174559"
  },
  {
    "skills": "clojure",
    "average_yearly_salary": "170867"
  },
  {
    "skills": "couchdb",
    "average_yearly_salary": "170000"
  },
  {
    "skills": "neo4j",
    "average_yearly_salary": "169598"
  },
  {
    "skills": "mongo",
    "average_yearly_salary": "167056"
  },
  {
    "skills": "solidity",
    "average_yearly_salary": "166250"
  },
  {
    "skills": "django",
    "average_yearly_salary": "163000"
  },
  {
    "skills": "zoom",
    "average_yearly_salary": "162429"
  },
  {
    "skills": "julia",
    "average_yearly_salary": "160500"
  },
  {
    "skills": "kubernetes",
    "average_yearly_salary": "158550"
  },
  {
    "skills": "redis",
    "average_yearly_salary": "158385"
  },
  {
    "skills": "mxnet",
    "average_yearly_salary": "157500"
  },
  {
    "skills": "fastapi",
    "average_yearly_salary": "157500"
  },
  {
    "skills": "splunk",
    "average_yearly_salary": "156844"
  },
  {
    "skills": "graphql",
    "average_yearly_salary": "156398"
  },
  {
    "skills": "watson",
    "average_yearly_salary": "155000"
  },
  {
    "skills": "unify",
    "average_yearly_salary": "154625"
  },
  {
    "skills": "numpy",
    "average_yearly_salary": "154377"
  },
  {
    "skills": "trello",
    "average_yearly_salary": "153000"
  },
  {
    "skills": "terminal",
    "average_yearly_salary": "153000"
  },
  {
    "skills": "perl",
    "average_yearly_salary": "152636"
  },
  {
    "skills": "golang",
    "average_yearly_salary": "152400"
  }
]
*/