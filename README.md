# Olist E-Commerce Revenue Leakage Analysis

**Identifying $7.2M in Revenue Optimization Opportunities Through Data Analytics**

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)
[![SQL](https://img.shields.io/badge/SQL-MySQL-orange.svg)](https://www.mysql.com/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow.svg)](https://powerbi.microsoft.com/)

---

## 📊 Project Overview

Comprehensive analysis of 99,441 e-commerce orders from Brazilian marketplace Olist to identify revenue leakage patterns and quantify business impact of operational improvements.

**Key Results:**
- **$7.2M total addressable opportunity** identified across 4 strategic areas
- **Customer retention crisis:** 3.1% vs 15-20% industry benchmark = $3.17M opportunity
- **Seller quality paradox:** 57% revenue from poor performers = $3.19M lost LTV
- **Geographic/seasonal insights:** $797K in preventable operational losses

**Analysis Period:** September 2016 - October 2018  
**Data Volume:** 99,441 orders | 96,096 customers | 3,095 sellers | 32,951 products

---

## 🎯 Business Problem

Olist connects small/medium Brazilian sellers to customers via major e-commerce platforms. Despite significant transaction volume, the business faces:
- Poor customer retention rates
- Inconsistent seller performance
- Geographic delivery disparities
- Seasonal capacity constraints

**Central Question:** Where is revenue leaking, and which interventions generate highest ROI?

---

## 📁 Repository Structure

```
olist-revenue-analysis/
│
├── data/
│   ├── raw/                          # Original Kaggle dataset (8 CSV files)
│   └── processed/                    # Cleaned analytical tables
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb        # Data preparation & quality checks
│   └── business_insights (02 TO 04)       # Core analysis & findings
│    
├── sql/
│   ├── 01_retention_analysis.sql     # Customer retention queries
│   ├── 02_cohort_retention_analysis.sql  # Cohort analysis
│   └── 03_seasonal_delay_patterns.sql    # Seasonal trend analysis
│
├── dashboards/
│   ├── olist_executive_dashboard.pbix    # Power BI dashboard
│   └── screenshots/                       # Dashboard images
│
├── results/
│   ├── executive_summary.pdf         # 1-page business summary
│   └── findings_summary.md           # Detailed findings document
│
├── README.md
└── requirements.txt
```

---

## 💡 Key Findings

### 1️⃣ Customer Retention Crisis — $3.17M Opportunity

**Discovery:**
- Only **3.1%** of customers make repeat purchases
- Industry benchmark: **15-20%**
- Gap represents **11,436 lost repeat customers annually**

**Root Cause:**
- First-order delays reduce repeat rate from 3.44% to 2.79% (only 0.65% impact)
- **Real issue:** Zero post-purchase engagement (no emails, loyalty programs, win-backs)
- 97% of customers receive order and never hear from Olist again

**Business Impact:**
```
Target repeat rate: 15% (conservative)
Current: 3.1%
Lost customers: 11,436
Avg repeat customer LTV: $277.30
Revenue Opportunity: $3,171,203
```

**Recommendations:**
| Initiative | Expected Lift | Revenue Impact | ROI |
|-----------|---------------|----------------|-----|
| Post-purchase email campaigns | +5-7% repeat rate | $1.3-1.9M | 26-38x |
| Loyalty rewards program | +3-5% repeat rate | $800K-1.4M | 27-47x |
| Lapsed customer win-backs | +2-4% recovery | $400K-800K | 20-40x |

---

### 2️⃣ Seller Quality Paradox — $3.19M Lost LTV

**Discovery:**
- **57%** of revenue comes from poorly-performing sellers ("Risky Cash Cows")
- These 822 sellers generate **$9.05M** but destroy **$3.19M** in customer lifetime value

**Seller Segmentation:**

| Segment | Sellers | Revenue | Delay % | Avg Rating | 1-Star % |
|---------|---------|---------|---------|------------|----------|
| **Stars** | 726 | $6.24M (39%) | 4.3% | 4.43 | 5.3% |
| **Risky Cash Cows** | 822 | $9.05M (57%) | 9.3% | 3.71 | 19.3% |
| **Hidden Gems** | 819 | $285K (1.8%) | 1.6% | 4.80 | 0.8% |
| **Deadweight** | 728 | $263K (1.7%) | 10.4% | 2.94 | 34.7% |

**Business Impact:**
```
Risky Cash Cows create: 11,511 poor customer experiences
Customer LTV destroyed: $3,190,000
```

**Recommendations:**
- Seller performance scorecard (mandatory tracking)
- 90-day probation program for underperformers
- Gradual shift to Stars/Hidden Gems (reduce dependency)
- Expected impact: $1-1.5M LTV recovery in Year 1

---

### 3️⃣ Geographic Hotspot — Rio de Janeiro ($113K)

**Discovery:**
- Rio de Janeiro has **12.7%** delay rate
- São Paulo has **4.2%** delay rate (3x better for same products)

**Top Problem Categories:**

| Category | RJ Delay % | SP Delay % | Orders (RJ) |
|----------|------------|------------|-------------|
| Bed/Bath/Table | 13.93% | 3.71% | 1,644 |
| Sports/Leisure | 12.49% | 4.20% | 1,041 |
| IT/Accessories | 12.57% | 4.26% | 1,002 |
| Furniture/Decor | 11.19% | 4.79% | 1,090 |

**Business Impact:**
```
Avoidable delays if RJ matched SP: 407
Customer LTV impact: $112,968
```

**Recommendations:**
- Audit RJ carrier partnerships
- Establish backup delivery options
- Adjust delivery promises (RJ +2 days)

---

### 4️⃣ Seasonal Delay Spikes — $684K Impact

**Discovery:**
- Normal months: **3.2%** delay rate
- Spike months (Nov, Feb, Mar): **14.7%** delay rate (4.6x worse)

**Pattern Analysis:**

| Month | Delay Rate | Cause |
|-------|------------|-------|
| **November 2017** | 11.98% | Black Friday rush |
| December 2017 | 7.24% | Holiday orders |
| **February 2018** | 13.78% | Post-holiday backlog |
| **March 2018** | 18.42% | Carnival + backlog |

**Business Impact:**
```
Spike month orders: 21,483
Excess delays (above normal): 2,466
Customer LTV impact: $683,934
```

**Recommendations:**
- Pre-negotiate carrier capacity for Q4 (+40%)
- Restrict high-risk sellers during Nov-Dec
- Dynamic delivery promises during peaks

---

## 🛠️ Technical Implementation

### Technologies Used

**Data Processing & Analysis:**
- Python 3.8+ (Pandas, NumPy)
- Jupyter Notebooks

**Database & Queries:**
- MySQL
- Advanced SQL: CTEs, Window Functions (ROW_NUMBER, FIRST_VALUE, LAG)

**Visualization:**
- Power BI Desktop

**Version Control:**
- GitHub

### Key Techniques

**Data Engineering:**
- Merged 8 relational tables (orders, customers, sellers, products, reviews, payments, items, geo)
- Handled missing values, duplicates, data type conversions
- Created analytical base tables optimized for business questions

**Statistical Analysis:**
- Cohort retention curve modeling
- Correlation analysis (delivery performance vs customer behavior)
- Segmentation using business logic and percentile thresholds

**SQL Proficiency:**
```sql
-- Example: Cohort Retention Analysis
WITH customer_cohorts AS (
    SELECT 
        customer_unique_id,
        DATE_FORMAT(MIN(order_purchase_timestamp), '%Y-%m-01') AS cohort_month
    FROM order_level
    GROUP BY customer_unique_id
),
monthly_activity AS (
    SELECT 
        c.cohort_month,
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m-01') AS activity_month,
        COUNT(DISTINCT o.customer_unique_id) AS active_customers
    FROM order_level o
    JOIN customer_cohorts c ON o.customer_unique_id = c.customer_unique_id
    GROUP BY c.cohort_month, activity_month
)
SELECT 
    cohort_month,
    activity_month,
    active_customers,
    ROUND(100.0 * active_customers / 
        FIRST_VALUE(active_customers) OVER (
            PARTITION BY cohort_month ORDER BY activity_month
        ), 2) AS retention_pct
FROM monthly_activity;
```

---

## 📈 Business Impact Summary

### Consolidated Recommendations (Prioritized by ROI)

| Rank | Initiative | Investment | Expected Return | ROI | Timeline |
|------|-----------|------------|-----------------|-----|----------|
| 1 | Post-purchase email campaigns | $50K | $1.3-1.9M | 26-38x | 60 days |
| 2 | Seller performance scorecard | $40K | $1.0-1.5M | 25-38x | 90 days |
| 3 | Loyalty rewards program | $30K | $800K-1.4M | 27-47x | 90 days |
| 4 | Seasonal capacity planning | $25K | $300-400K | 12-16x | 120 days |
| 5 | RJ carrier optimization | $15K | $60-80K | 4-5x | 60 days |
| 6 | Lapsed customer win-backs | $20K | $400-800K | 20-40x | 60 days |

**Total Investment:** ~$180K  
**Total Expected Return (Year 1):** $3.8-5.2M  
**Blended ROI:** 21-29x

---

## 🚀 How to Run This Analysis

### Prerequisites

```bash
# Python 3.8 or higher
python --version

# Install required packages
pip install -r requirements.txt
```

### Setup

1. **Clone Repository**
```bash
git clone https://github.com/yourusername/olist-revenue-analysis.git
cd olist-revenue-analysis
```

2. **Download Dataset**
- Source: [Kaggle - Brazilian E-Commerce Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- Place CSV files in `data/raw/` directory

3. **Run Analysis**
```bash
# Data cleaning
jupyter notebook notebooks/01_data_cleaning.ipynb

# Business insights
jupyter notebook notebooks/02_business_insights.ipynb
```

4. **SQL Queries** 
```bash
# Import cleaned data to MySQL
mysql -u username -p database_name < sql/import_data.sql

# Run analysis queries
mysql -u username -p database_name < sql/01_retention_analysis.sql
```

5. **View Dashboard**
- Open `dashboards/olist_executive_dashboard.pbix` in Power BI Desktop
- Or view screenshots in `dashboards/screenshots/`

---

## 📊 Dashboard Preview

**4-Page Executive Dashboard:**

### Page 1: Business Health Overview
- KPI Cards: Total Orders, Revenue, Delay %, Avg Review Score
- Monthly order trends
- Top categories and states

### Page 2: Retention Deep-Dive
- Repeat rate by first-order experience
- Customer distribution (1-time, 2-3 orders, 4+ orders)
- Cohort retention analysis

### Page 3: Seller Performance Matrix
- Segmentation scatter plot (Revenue vs Performance)
- Performance metrics by segment
- High-risk seller identification

### Page 4: Geographic & Seasonal Insights
- State-level delay rate heatmap
- Monthly delay trends with spike identification
- Seasonal pattern analysis

![Dashboard Preview](dashboards/screenshots/dashboard_overview.png)

---

## 🎓 Skills Demonstrated

- **Business Analytics:** Revenue impact modeling, ROI prioritization, stakeholder communication
- **Data Engineering:** Multi-table joins, data cleaning, feature engineering
- **SQL:** CTEs, window functions, complex aggregations
- **Python:** Pandas data manipulation, statistical analysis
- **Data Visualization:** Executive dashboards, cohort heatmaps, KPI tracking
- **Strategic Thinking:** Root cause analysis, constraint recognition (can't remove high-revenue sellers)

---

## 📝 Key Learnings

### What Worked Well
- Revenue-first framing (not just technical metrics)
- Cohort analysis revealed retention patterns invisible in aggregate metrics
- Seller segmentation exposed the "quality vs revenue" tradeoff

### What I'd Do Differently
- Include customer survey data to validate engagement hypothesis
- Build predictive churn model (logistic regression) for proactive intervention
- Conduct A/B test framework before full recommendation rollout

### Critical Insight
**The biggest finding challenged the initial hypothesis:**

Everyone assumed delivery delays were the main problem. Data revealed delays account for only $11K of a $3.17M retention issue. The real problem: **systematic absence of customer engagement.**

This is what data analysts do — **find the truth hiding in the numbers.**

---

## 🔗 Links & Resources

- **Interactive Dashboard:** [Power BI Service Link] *(link expired)*
- **Dataset Source:** [Kaggle - Olist E-Commerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- 
---

## 📄 License

This project is for educational and portfolio purposes. Dataset provided by Olist under [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

---

## 👤 About

**Author:** [Suraj Rajput]  
**Role:** Aspiring Data Analyst | SaaS Analytics Specialist  
**Focus:** Revenue analytics, customer retention, business metrics (MRR, LTV, Churn)

**Contact:** [suraj.rajput.work@outlook.com] / [rajputsuraj2006@gmail.com]

---

## 🙏 Acknowledgments

- **Olist** for providing the dataset
- **Kaggle** for hosting the data
- **Brazilian E-Commerce community** for data transparency

---

**Project Status:** ✅ Complete  
**Last Updated:** April 2025

---

*Built with ❤️ and ☕ | Turning data into revenue decisions*
```
