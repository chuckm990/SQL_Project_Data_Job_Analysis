<div align="center">

# 📊 Data Engineer Job Market Analysis

### A SQL-driven dive into top-paying roles, in-demand skills, and salary trends.

<p align="center">
  <img src="https://img.shields.io/badge/SQL-000000?style=for-the-badge&logo=sql&logoColor=white" alt="SQL Badge"/>
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL Badge"/>
  <img src="https://img.shields.io/badge/Python-FFD43B?style=for-the-badge&logo=python&logoColor=blue" alt="Python Badge"/>
  <br>
  <img src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white" alt="VSCode Badge"/>
  <img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white" alt="Git Badge"/>
  <img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Badge"/>
</p>

🚧 _Check out the SQL queries in the [project_sql folder](/project_sql/)_ 🚧

</div>

# Table of Contents

-   [Introduction](#introduction)
-   [Background](#background)
-   [Tools I Used](#tools-i-used)
-   [The Analysis](#the-analysis)
    -   [1. Top Paying Data Engineer Jobs](#1-top-paying-data-engineer-jobs)
    -   [2. Must-have Skills for Top Paying Data Engineering Jobs](#2-must-have-skills-for-top-paying-data-engineering-jobs)
    -   [3. Top Demanded Skills for Data Engineering Jobs](#3-top-demanded-skills-for-data-engineering-jobs)
    -   [4. Top Paying Skills (not job specific)](#4-top-paying-skills-not-job-specific)
    -   [5. Optimal Skills to Learn](#5-optimal-skills-tradeoff-between-high-paying-job-postings-and-top-paying-skills)
-   [What I Learned](#what-i-learned)
-   [Conclusions](#conclusions)

---

# Introduction

Dive into the data job market 📊🚀
Focusing on data engineer roles, this project explores top-paying jobs 💰, in-demand skills 🧠, and where high demand meets high salary in data engineering 🔧📈.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)

# Background

Driven by a quest for learning the basics of SQL, and acquiring the necessary tools for doing simple queries, up to doing subqueries and CTEs, with joins and other cool stuff. This project is my first one on SQL, and I had the guidance of Luke Barousse, kudos to him!

Data hails from Luke's [SQL Course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to address through my SQL queries were:

1. What are the top-paying jobs for my role?
2. What are the skills required for these top-paying roles?
3. What are the most in-demand skills for my role?
4. What are the top skills based on salary for my role?
5. What are the most optimal skills to learn?

# Tools I used

For my deep dive into the data engineer job market, I harnessed the power of several key tools:

-   **SQL:** the backbone of my analysis, allowing me to query the database and unveil critical insights.
-   **PostgreSQL:** the chosen DBMS, ideal for handling the job posting data
-   **VSCode:** my go-to for database management and executing SQL queries.
-   **Git & GitHub:** essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The analysis

Each query for this project aimed at investigating specific aspects of the data engineer job market. Here's how I approached each question:

### 1. Top Paying Data Engineer Jobs

To identify the highest-paying roles, I filtered data engineer positions by average yearly salary and location, focusing on remote jobs, and those in Argentina (where I currently live as of Jan 2026). This query highlights the high paying opportunities in the field.

```sql
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
```

Here's a brief analysis of the results

## 🔍 Key Insights from Top-Paying Data Engineering Roles

### 1️⃣ Seniority strongly correlates with top compensation

Across the highest-paying postings, job titles are heavily skewed toward **Staff, Principal, Lead, and Manager** roles.
Entry-level or mid-level “Data Engineer” titles do appear, but the **$200k+ range is dominated by senior ICs and leadership positions**, indicating that compensation scales sharply with scope and ownership rather than just technical ability.

**Takeaway:** To access top-tier salaries, career progression matters as much as stack depth.

---

### 2️⃣ A small set of companies repeatedly offer top-tier pay

From the top-paying subset, companies like **Meta, Capital One, MongoDB, and Harnham** appear multiple times, suggesting that:

-   These organizations consistently value data engineering at a strategic level
-   High compensation is not a one-off posting, but part of a broader hiring pattern

This concentration is visible in the chart you generated.

**Takeaway:** Targeting companies with repeated high-salary postings may be more effective than chasing isolated outliers.

---

### 3️⃣ Fully remote roles dominate the highest salaries

Almost every posting in the top-paying group lists the location as **“Anywhere”**, even when companies are US-based.
This suggests that **remote work is not a trade-off for lower pay** in data engineering—in fact, it appears to be the norm at the high end of the market.

**Takeaway:** Geography is becoming less relevant than seniority and impact for top compensation.

![](assets\role_type_vs_average_salary.png)

> _This chart shows how compensation increases with seniority among data engineering roles. Staff, Principal, and Director-level positions command the highest average salaries, while standard Data Engineer roles appear lower even within top-paying postings._

### 2. Must-have Skills for Top Paying Data Engineering Jobs

The highest-paying Data Engineer roles emphasize **platform ownership, distributed systems, and senior-level responsibility** over niche or trendy tools. Python and Spark form the core, but top compensation is driven by engineers who can design, scale, and lead cloud-native data platforms end to end.

Next, the query:

```sql
WITH top_paying_jobs AS(
    SELECT
        job_postings.job_id,
        job_postings.job_title,
        companies.name AS company_name,
        job_postings.salary_year_avg
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
)

SELECT
    top_paying_jobs.*, -- what this does is to select all columns from the top_paying_jobs table
    skills_dim.skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```

#### 1️⃣ Top pay is driven by **platform ownership**, not just coding

Across the highest salaries ($250k–$325k), the skill sets consistently bundle:

-   **Core language**: Python (almost universal)
-   **Distributed compute**: Spark / PySpark
-   **Ecosystem tools**: Hadoop, Kafka, Databricks
-   **Infra / orchestration**: Kubernetes, cloud (AWS/GCP/Azure)

➡️ **Insight:**
High-paying Data Engineer roles are **not “Python-only” jobs**. They reward engineers who can **own end-to-end data platforms**: ingestion → processing → deployment → scaling.

This explains why:

-   Pandas/Numpy appear _only_ alongside Spark
-   Pure analytics stacks don’t dominate the very top salaries

💡 _Translation for job seekers:_
Python is table stakes; **system-level thinking** is what unlocks top pay.

---

#### 2️⃣ Salary correlates more with **scope & seniority** than with “new” tools

Notice the pattern:

-   **$300k–$325k roles** → classic big-data stack (Python, Spark, Kafka, Hadoop)
-   **$240k–$260k roles** → senior titles (Staff / Principal / Manager)
-   ML frameworks (TensorFlow, PyTorch, Keras) appear **only** in a **Director-level role**

➡️ **Insight:**
There is **no strong evidence that cutting-edge ML tools alone increase pay** for Data Engineers. Instead:

-   Pay increases with **architectural responsibility**
-   Leadership and platform direction matter more than novelty

💡 This cleanly separates **Data Engineer** from **ML Engineer** at the top end.

---

#### 3️⃣ High-paying roles favor **polyglot + cloud-native engineers**

Beyond Python, top roles repeatedly ask for:

-   **Scala / Go / Java** (performance & JVM ecosystem)
-   **SQL + NoSQL** (data modeling maturity)
-   **Multi-cloud exposure** (AWS + GCP + Azure in the same dataset)

➡️ **Insight:**
The best-paid Data Engineers are **language-flexible and cloud-agnostic**.
They’re hired to **adapt platforms**, not just work within one stack.

This also explains why:

-   Scala shows up strongly in Principal / Staff roles
-   Go appears in Staff-level engineering roles
-   Cloud skills are spread across _multiple_ providers, not locked to one

### 3. Top Demanded Skills for Data Engineering Jobs

### Key insight

-   **SQL (18,701)** and **Python (18,497)** form the **absolute foundation** of Data Engineering roles.
-   The difference between them is marginal (~1.1%), meaning:

    -   Employers almost universally expect **both**, not one or the other.

### Interpretation

This strongly suggests:

-   Data Engineering is still **data-modeling and data-access centric**, not purely infrastructure-focused.
-   Even for remote roles, companies prioritize engineers who can:

    -   Design and query data models (SQL)
    -   Orchestrate, transform, and automate pipelines (Python)

📌 **Implication**: Any candidate missing either SQL or Python is filtered out early.

The query ended up like this:

```sql
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
```

### 4. Top Paying Skills (not job specific)

### Top-paying Data Engineer roles in 2023 tend to:

-   Be **senior or staff-level**
-   Sit at the **intersection of data + systems + infra**
-   Value **rare languages** and **architectural depth**
-   Optimize for **performance, scale, or research**, not dashboards

### Market structure (simplified):

-   **SQL/Python** → employability
-   **Cloud + orchestration** → mid-level growth
-   **Systems, niche DBs, low-level languages** → compensation ceiling

> **Demand skills get you hired. Scarce skills get you paid more.**

High-paying DE roles assume:

-   You _already_ know SQL, Python, cloud
-   Salary is driven by what you bring **on top of the baseline**

The final query:

```sql
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
```

### 5. Optimal Skills (tradeoff between high paying job postings and top paying skills)

Key insights from this query

-   **High pay often comes from scarcity, not popularity**: The top salaries are tied to low-demand, niche skills (e.g. Mongo, Redis, Splunk), reflecting scarcity and senior ownership rather than broad market opportunity.

-   **Best ROI skills balance demand and salary**: Kafka, Spark, Scala, Kubernetes, and Terraform combine strong demand with high pay, making them the most strategic skills for both employability and compensation.

-   **Infrastructure and scale outperform pure analytics**: Skills tied to distributed systems, cloud infrastructure, and reliability consistently pay more than data-manipulation or analysis-focused tools.

-   **Streaming and real-time systems are clear pay accelerators**: Kafka-centric and event-driven architectures stand out as both highly demanded and well-compensated, signaling their growing business criticality.

```sql
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
```

# What I learned

I have learned how to build queries, from basic selection of columns to understanding the complexity and structure of syntax and its importance for better readability into production environments. I have learned how to retrieve information from a database, using LiteSQL and most importantly PostgreSQL inside the VSCode IDE.

I have also refreshed some concepts of working with GitHub, and uploading this project entirely from VSCode.

I can now read queries in a different way and understand the concepts of creating and querying from a database, which is crucial for my journey into data engineering.

I have learned when and how to use different clauses, which is important to speed up and work better with databases.

# Conclusions

This analysis confirms that while **SQL and Python** are the non-negotiable foundations of Data Engineering, they are just the entry point.

Top-tier compensation is driven by **specialized infrastructure skills** (Kafka, Spark, Kubernetes) and **architectural ownership** rather than just coding ability. High-paying roles favor engineers who can build end-to-end distributed systems, often in **fully remote** environments.

Ultimately, to maximize market value, data engineers must evolve from simple data manipulation to mastering **cloud-native platforms** and **scalable system design**.
