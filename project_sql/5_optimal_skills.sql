/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Engineer roles.
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
    offering strategic insights for career development in data analysis
*/
WITH skills_demand AS(
    SELECT
        skills_dim.skill_id,
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short LIKE '%Data%' AND
        job_title_short LIKE '%Engineer%' AND
        job_work_from_home = true AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), average_salary AS(
    SELECT
        skills_dim.skill_id,
        skills,
        ROUND(AVG(salary_year_avg), 0) AS average_yearly_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short LIKE '%Data%' AND
        job_title_short LIKE '%Engineer%' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = true
    GROUP BY
        skills_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_yearly_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    average_yearly_salary DESC,
    demand_count DESC
LIMIT 25;

-- Rewriting the query more concisely
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND((AVG(job_postings_fact.salary_year_avg)), 0) AS average_yearly_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data%'
    AND job_title_short LIKE '%Engineer%'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    average_yearly_salary DESC,
    demand_count DESC
LIMIT 25;

/*
Key insights from this query
* **High pay often comes from scarcity, not popularity**: The top salaries are tied to low-demand, niche skills (e.g. Mongo, Redis, Splunk), reflecting scarcity and senior ownership rather than broad market opportunity.

* **Best ROI skills balance demand and salary**: Kafka, Spark, Scala, Kubernetes, and Terraform combine strong demand with high pay, making them the most strategic skills for both employability and compensation.

* **Infrastructure and scale outperform pure analytics**: Skills tied to distributed systems, cloud infrastructure, and reliability consistently pay more than data-manipulation or analysis-focused tools.

* **Streaming and real-time systems are clear pay accelerators**: Kafka-centric and event-driven architectures stand out as both highly demanded and well-compensated, signaling their growing business criticality.


Results:

[
  {
    "skill_id": 24,
    "skills": "mongo",
    "demand_count": "14",
    "average_yearly_salary": "167056"
  },
  {
    "skill_id": 213,
    "skills": "kubernetes",
    "demand_count": "85",
    "average_yearly_salary": "158550"
  },
  {
    "skill_id": 55,
    "skills": "redis",
    "demand_count": "13",
    "average_yearly_salary": "158385"
  },
  {
    "skill_id": 193,
    "skills": "splunk",
    "demand_count": "11",
    "average_yearly_salary": "156844"
  },
  {
    "skill_id": 116,
    "skills": "graphql",
    "demand_count": "11",
    "average_yearly_salary": "156398"
  },
  {
    "skill_id": 94,
    "skills": "numpy",
    "demand_count": "18",
    "average_yearly_salary": "154377"
  },
  {
    "skill_id": 31,
    "skills": "perl",
    "demand_count": "11",
    "average_yearly_salary": "152636"
  },
  {
    "skill_id": 27,
    "skills": "golang",
    "demand_count": "15",
    "average_yearly_salary": "152400"
  },
  {
    "skill_id": 63,
    "skills": "cassandra",
    "demand_count": "31",
    "average_yearly_salary": "152367"
  },
  {
    "skill_id": 98,
    "skills": "kafka",
    "demand_count": "193",
    "average_yearly_salary": "151986"
  },
  {
    "skill_id": 99,
    "skills": "tensorflow",
    "demand_count": "14",
    "average_yearly_salary": "150601"
  },
  {
    "skill_id": 144,
    "skills": "ruby",
    "demand_count": "17",
    "average_yearly_salary": "148882"
  },
  {
    "skill_id": 30,
    "skills": "ruby",
    "demand_count": "17",
    "average_yearly_salary": "148882"
  },
  {
    "skill_id": 212,
    "skills": "terraform",
    "demand_count": "67",
    "average_yearly_salary": "148632"
  },
  {
    "skill_id": 11,
    "skills": "css",
    "demand_count": "11",
    "average_yearly_salary": "148045"
  },
  {
    "skill_id": 62,
    "skills": "mongodb",
    "demand_count": "48",
    "average_yearly_salary": "147723"
  },
  {
    "skill_id": 18,
    "skills": "mongodb",
    "demand_count": "48",
    "average_yearly_salary": "147723"
  },
  {
    "skill_id": 154,
    "skills": "node",
    "demand_count": "11",
    "average_yearly_salary": "145591"
  },
  {
    "skill_id": 3,
    "skills": "scala",
    "demand_count": "171",
    "average_yearly_salary": "145448"
  },
  {
    "skill_id": 93,
    "skills": "pandas",
    "demand_count": "50",
    "average_yearly_salary": "144179"
  },
  {
    "skill_id": 101,
    "skills": "pytorch",
    "demand_count": "13",
    "average_yearly_salary": "143977"
  },
  {
    "skill_id": 59,
    "skills": "elasticsearch",
    "demand_count": "30",
    "average_yearly_salary": "143918"
  },
  {
    "skill_id": 223,
    "skills": "ansible",
    "demand_count": "12",
    "average_yearly_salary": "143417"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "331",
    "average_yearly_salary": "142913"
  },
  {
    "skill_id": 26,
    "skills": "c",
    "demand_count": "12",
    "average_yearly_salary": "142852"
  }
]
*/