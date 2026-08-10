# Exploratory Data Analysis with SQL: Data Engineer Job Market Analytics

A SQL-based analytical project exploring the data engineer job market using real-world job posting data. The project demonstrates how a structured data warehouse can be queried to answer business-oriented questions around **skill demand, compensation, and the relative value of technical skills**.

The analysis focuses on writing efficient analytical SQL across a relational warehouse, applying aggregation and statistical functions, and transforming raw job-market data into actionable insights.

---

## Executive Summary
![Project 1 overview](///images/27.png)


This project addresses three core questions relevant to the data engineering job market:

1. **Which technical skills are most in demand?**
2. **Which skills are associated with the highest salaries?**
3. **Which skills provide the strongest combination of market demand and compensation?**

### Project Scope

* Developed **three analytical SQL queries** focused on demand, compensation, and skill optimization.
* Queried a **star-schema data warehouse** using fact, dimension, and bridge tables.
* Implemented **multi-table joins** to connect job postings with associated skills.
* Applied aggregation, statistical analysis, filtering, ranking, and mathematical transformations.
* Derived an **optimal skill score** combining skill demand and median compensation.
* Extracted practical insights into the technical skill requirements of modern data engineering roles.

---

## Business Problem

The data engineering job market contains thousands of job postings with varying requirements, salaries, technologies, and skill combinations. Simply identifying frequently mentioned technologies does not necessarily indicate which skills provide the greatest career value.

This project therefore separates the analysis into three dimensions:

| Analysis           | Business Question                                                     |
| ------------------ | --------------------------------------------------------------------- |
| Skill Demand       | Which skills appear most frequently in data engineering job postings? |
| Salary             | Which skills are associated with higher compensation?                 |
| Skill Optimization | Which skills offer a strong balance between demand and salary?        |

The goal is to demonstrate how SQL can be used not only to retrieve data, but also to **translate business questions into measurable analytical metrics**.

---

## Data Warehouse Architecture

The analysis operates on a warehouse structured using a **star schema**.

### Schema Components

**Fact Table**

* `job_postings_fact` — Central fact table containing job posting attributes such as job title, location, salary, work arrangement, and posting date.

**Dimension Tables**

* `company_dim` — Company-level information associated with job postings.
* `skills_dim` — Skill catalog containing skill names and classifications.

**Bridge Table**

* `skills_job_dim` — Maps job postings to their associated skills and resolves the many-to-many relationship between jobs and skills.

### Relationship Overview

![Project 1 overview](///images/26.png)

The bridge table is particularly important because a single job posting can require multiple skills, while the same skill can appear across thousands of job postings.

This structure allows the analytical queries to move from individual job postings to skill-level market statistics.

---

## Analytical Queries

### 1. Top Demanded Skills

[`01_top_demanded_skills.sql`](./01_top_demanded_skills.sql)

Identifies the most frequently requested skills among remote data engineering positions.

The analysis uses:

* Multi-table joins
* Job-level filtering
* Skill-level grouping
* Posting counts
* Descending ranking
* Top-N filtering

**Primary metric:**

`COUNT(job_id)`

The resulting analysis highlights the technologies most commonly requested by employers.

![Project 1 overview](///images/23.png)
---

### 2. Top Paying Skills

[`02_top_paying_skills.sql`](./02_top_paying_skills.sql)

Examines the relationship between technical skills and annual compensation.

The query calculates:

* Median annual salary
* Number of job postings associated with each skill
* Skill-level salary rankings

**Primary metric:**

`MEDIAN(salary_year_avg)`

Median salary is used instead of a simple average to reduce the influence of unusually high or low compensation values.
![Project 1 overview](///images/23.png)
---

### 3. Optimal Skills

[`03_optimal_skills.sql`](./03_optimal_skills.sql)

Combines demand and compensation into a single analytical framework to identify skills that provide a strong balance between market demand and earning potential.

The query applies a logarithmic transformation to demand:

```sql
LN(demand_count)
```

This prevents extremely high-demand skills from disproportionately dominating the resulting score.

The resulting metric combines:

* Skill demand
* Median salary
* Minimum demand threshold

This provides a more balanced perspective than ranking skills using salary or demand independently.
![Project 1 overview](///images/25.png)
---

## Key Findings

### Core Programming and Query Languages

**SQL and Python** emerge as the dominant technical skills, each appearing in approximately 29,000 job postings within the analyzed dataset.

Their high frequency indicates that foundational programming and data querying capabilities remain central requirements for data engineering roles.

### Cloud Platforms

Cloud technologies such as **AWS and Microsoft Azure** demonstrate significant demand, reflecting the industry's shift toward cloud-based data infrastructure.

### Infrastructure and DevOps

Technologies including **Kubernetes, Docker, and Terraform** are associated with comparatively strong compensation, highlighting the value of infrastructure and deployment knowledge within data engineering.

### Big Data Technologies

**Apache Spark** demonstrates both substantial market demand and competitive compensation, reinforcing its relevance for large-scale data processing environments.

> The findings represent patterns within the analyzed job-posting dataset and should not be interpreted as universal salary or hiring-market guarantees.

---

## SQL Techniques Demonstrated

### Relational Querying

* Multi-table `INNER JOIN` operations
* Fact-to-dimension relationships
* Fact-to-bridge-to-dimension relationships
* Many-to-many relationship analysis

### Aggregation and Statistical Analysis

* `COUNT()`
* `MEDIAN()`
* `ROUND()`
* `GROUP BY`
* `HAVING`

### Filtering

Conditional filtering using:

```sql
WHERE job_title_short = 'Data Engineer'
  AND job_work_from_home = TRUE
  AND salary_year_avg IS NOT NULL
```

This ensures that the analysis is performed against relevant and sufficiently complete records.

### Ranking and Result Limiting

```sql
ORDER BY ... DESC
LIMIT ...
```

Used to perform top-N analysis and identify the highest-demand and highest-paying skills.

### Mathematical Transformation

```sql
LN(demand_count)
```

Natural logarithmic transformation is used to reduce the effect of extreme differences in demand when calculating the optimal skill score.

### Data Quality Handling

The analysis explicitly filters incomplete salary records:

```sql
salary_year_avg IS NOT NULL
```

This prevents missing compensation values from distorting salary-based metrics.

---

## Technology Stack

| Technology  | Purpose                                          |
| ----------- | ------------------------------------------------ |
| **DuckDB**  | Analytical SQL query engine                      |
| **SQL**     | Data analysis and transformation                 |
| **VS Code** | SQL development environment                      |
| **Git**     | Version control                                  |
| **GitHub**  | Source-code management and project documentation |

DuckDB was selected because its columnar, OLAP-oriented architecture makes it particularly well suited for analytical workloads over structured datasets.

---

## Repository Structure

```text
1_EDA/
│
├── 01_top_demanded_skills.sql
├── 02_top_paying_skills.sql
├── 03_optimal_skills.sql
│
├── images/
│   ├── top_demanded_skills.png
│   ├── top_paying_skills.png
│   └── optimal_skills.png
│
└── README.md
```

---

## Analysis Results

### Top Demanded Skills

The following visualization shows the most frequently requested technical skills within the analyzed data engineering job postings.



---

### Top Paying Skills

This analysis highlights skills associated with the highest median annual salaries while considering their representation within the job market.



---

### Optimal Skills

The final analysis combines skill demand and compensation to identify skills that provide a stronger overall balance between market relevance and earning potential.



---

## Analytical Approach

The project follows a structured analytical workflow:

```text
Job Posting Data
       │
       ▼
Data Warehouse
       │
       ▼
Fact + Dimension + Bridge Tables
       │
       ▼
SQL Joins & Filtering
       │
       ▼
Aggregation & Statistical Analysis
       │
       ▼
Demand / Salary Metrics
       │
       ▼
Skill Optimization
       │
       ▼
Business Insights
```

This workflow demonstrates how analytical SQL can operate on top of a structured warehouse to transform transactional job-posting data into decision-oriented insights.

---

## Why This Project Matters

Although the analysis focuses on the data engineering job market, the primary objective is broader: **understanding how analytical workloads operate on top of a data warehouse**.

The project demonstrates the transition from:

**Raw Data → Data Model → SQL Transformations → Analytical Metrics → Business Insights**

This provides practical exposure to the type of workflow used when data engineers build and support analytical systems consumed by analysts, business teams, and decision-makers.

---

## Future Improvements

Potential extensions to the project include:

* Building automated ETL/ELT pipelines for job-posting ingestion
* Adding incremental data loading
* Creating historical salary and demand trends
* Segmenting analysis by geography and experience level
* Comparing cloud, database, orchestration, and programming skill categories
* Adding data-quality validation checks
* Materializing frequently used analytical datasets
* Building a BI dashboard on top of the analytical layer
* Automating query execution and reporting

---

## Conclusion

This project demonstrates practical SQL and data-warehouse analysis us.ing real-world job posting data.

Rather than treating SQL purely as a querying language, the project applies it as an analytical tool for understanding relationships across a structured warehouse, calculating meaningful metrics, and translating those metrics into business-oriented conclusions.

The resulting analysis provides a practical view of the skills shaping the data engineering job market while demonstrating core competencies in **SQL, relational data modeling, analytical querying, statistical aggregation, and data-driven problem solving**.
