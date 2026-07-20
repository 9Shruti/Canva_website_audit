# 🌐 Website Audit System

> 📊 A complete **Website Performance, SEO & Accessibility Audit System** for `https://www.canva.in/` — delivered as a spreadsheet report 📑 and a relational MySQL database 🗄️.

---

## 📌 Project Status

### ✅ Completed
- 🗄️ Database schema design (`website_audit_master`, `categories`, `sub_factors`, `factors`)
- 📊 Full 3-level audit scoring (Category → Sub-Factor → Factor)
- 📈 Excel report with 3 sheets (`INSIGHT`, `Sheet2`, `Sheet3`)
- 🛠️ SQL query optimization guide with before/after examples
- 📖 Project documentation (this README)

### 🚧 Currently Working On
- 🔄 Automating data sync between the spreadsheet and the MySQL database
- 📉 Adding historical audit tracking (multiple audits per website over time)
- 🎨 Improving Excel formatting/conditional colors for scores

### 🔮 Upcoming Features
- 📡 Live PageSpeed API integration for auto-refreshing scores
- 📊 Interactive dashboard (charts & graphs) built from the database
- 🔔 Score-drop alerts/notifications
- 🌍 Support for auditing multiple websites in one system

---

## 🎯 Project Objectives

- 🚀 Measure website health across **Performance, Accessibility, Best Practices & SEO**
- 🔽 Break every score down into a clear **3-level hierarchy** so issues are easy to trace
- 🗄️ Store audit results in a **structured, queryable database** instead of a flat report
- 🛠️ Provide **actionable SQL-level fixes** for real backend performance issues
- 📖 Make the whole audit understandable to both developers and non-technical stakeholders

---

## 🧰 Technologies Used

| Tool | Purpose |
|---|---|
| 🐬 MySQL | Relational database to store audit data |
| 📊 Microsoft Excel (.xlsx) | Human-readable audit report |
| 🐍 Python (openpyxl) | Reading/processing the spreadsheet |
| 🧮 SQL | Querying & optimizing audit + application data |
| 📝 Markdown | Documentation |

---

## 🗂️ Repository Structure

```
📁 website-audit-system/
│
├── 📄 Database_Schema.sql        # MySQL schema + seed data
├── 📊 canva_spreadsheet.xlsx     # Full audit report (3 sheets)
└── 📖 README.md                  # Project documentation (this file)
```

---

## 🗄️ Database Details

The database `canva_db` stores the audit as **4 connected tables**, forming a
drill-down hierarchy:

```
📋 website_audit_master   (1 audit per website)
        │
        ▼
🗂️ categories              (Performance, SEO, etc.)
        │
        ▼
📂 sub_factors             (LCP, TBT, Color Contrast, etc.)
        │
        ▼
🔬 factors                 (raw measured values + pass/fail flags)
```

| Table | 🔑 Key Field | 💡 Purpose |
|---|---|---|
| `website_audit_master` | `audit_id` | One row per audit run |
| `categories` | `category_id` | Top-level scores (C1–C4, OVR) |
| `sub_factors` | `sub_factor_id` | Mid-level metrics (P1, A1, B1, S1...) |
| `factors` | `factor_id` | Raw values, e.g. `P1F1` = 420ms |

🔗 **Relationships:** `website_audit_master` → `categories` → `sub_factors` → `factors` (each linked via foreign keys).

---

## ✨ Features

- 🏆 **Overall Website Score** — single 0–100 health score
- 🔽 **3-Level Drill-Down** — Category → Sub-Factor → Factor, so any score can be traced to its root cause
- 🚦 **Status Flags** — Excellent / Good / Needs Improvement / ⚠️ Fix on every metric
- 🛠️ **SQL Fix Guide** — real before/after query optimizations mapped to specific PageSpeed issues
- 📖 **Data Dictionary** — built-in sheet explaining every field and level
- 🗄️ **Relational Storage** — same data available in Excel *and* MySQL

---

## 📁 Included Files

### 🗄️ `Database_Schema.sql`
- Creates the `canva_db` database and 4 core tables:
  `website_audit_master`, `categories`, `sub_factors`, `factors`
- Includes foreign key relationships linking each level of the hierarchy
- Comes pre-loaded with seed data for the `https://www.canva.in/` audit (Score: **87/100 — Good**)

### 📊 `canva_spreadsheet.xlsx`
| Sheet | Contents |
|---|---|
| 🛠️ `INSIGHT` | Prioritized PageSpeed issues + real SQL fixes & expected impact |
| 📈 `Sheet2` | Full 3-level scored audit (Category → Sub-Factor → Factor) |
| 📖 `Sheet3` | Data dictionary explaining the scoring structure |

---

## 🚀 Getting Started

### 1️⃣ Clone / Download the project
```bash
git clone https://github.com/your-username/website-audit-system.git
cd website-audit-system
```

### 2️⃣ Set up the database
```bash
mysql -u your_username -p < Database_Schema.sql
```

### 3️⃣ Verify the data
```sql
USE canva_db;
SELECT * FROM website_audit_master;
SELECT * FROM categories;
```

### 4️⃣ Open the report
Open `canva_spreadsheet.xlsx` in Excel / Google Sheets to explore the full breakdown visually.

---

## 🧪 Sample SQL Queries

**🏆 Get the overall website score**
```sql
SELECT website_url, overall_score, overall_status
FROM website_audit_master;
```

**📊 Get all category scores, sorted worst to best**
```sql
SELECT category_name, score, status
FROM categories
WHERE category_id != 'OVR'
ORDER BY score ASC;
```

**🔽 Drill down: all sub-factors for Performance (C1)**
```sql
SELECT sub_factor_name, score
FROM sub_factors
WHERE category_id = 'C1';
```

**⚠️ Find every factor that needs fixing**
```sql
SELECT factor_name, value, unit, good_range, flag
FROM factors
WHERE flag = '⚠ Fix';
```

**🔗 Full drill-down join (Category → Sub-Factor → Factor)**
```sql
SELECT c.category_name, s.sub_factor_name, f.factor_name, f.score, f.flag
FROM categories c
JOIN sub_factors s ON c.category_id = s.category_id
JOIN factors f ON s.sub_factor_id = f.sub_factor_id
ORDER BY c.category_name, s.sub_factor_name;
```

---

## 🗺️ Development Roadmap

| Phase | Status | Goal |
|---|---|---|
| 1️⃣ Schema Design | ✅ Done | Build normalized database structure |
| 2️⃣ Audit Scoring | ✅ Done | Implement 3-level scoring system |
| 3️⃣ Reporting | ✅ Done | Build Excel report + fix guide |
| 4️⃣ Automation | 🚧 In Progress | Sync spreadsheet ⇄ database automatically |
| 5️⃣ Live Data | 🔮 Planned | Connect to PageSpeed Insights API |
| 6️⃣ Dashboard | 🔮 Planned | Interactive charts for scores & trends |
| 7️⃣ Multi-Site Support | 🔮 Planned | Audit and compare multiple websites |

---

## 🔭 Future Scope

- 📡 Real-time auditing via Google PageSpeed Insights / Lighthouse API
- 📊 Web dashboard (React + charts) reading directly from `canva_db`
- 🕰️ Historical trend tracking — compare scores across audit dates
- 🤖 Auto-generated fix recommendations using AI
- 🌍 Multi-website & multi-user support
- 📧 Automated email/Slack reports after each audit

---

## 🤝 Contributing

Contributions are welcome! 🎉

1. 🍴 Fork this repository
2. 🌿 Create a new branch (`git checkout -b feature/your-feature`)
3. 💾 Commit your changes (`git commit -m "Add your feature"`)
4. 📤 Push to the branch (`git push origin feature/your-feature`)
5. 🔁 Open a Pull Request

Bug reports, feature ideas, and documentation improvements are all appreciated 🙌

---

## 👤 Author

**SHRUTI KADIYA** 
- 🔗 LinkedIn: https://www.linkedin.com/in/shruti-kadiya-677818419/ 
- 💻 GitHub: https://github.com/9Shruti
