# 🌐 Canva Website Audit Project

> 📊 A complete **Website Performance, SEO & Accessibility Audit** for `https://www.canva.in/` — delivered as a spreadsheet report 📑 and a relational MySQL database 🗄️.

---

## 📦 What's Inside

| 📁 File | 📝 What It Is |
|---|---|
| `canva_spreadsheet__2_.xlsx` | 📈 The full audit report — scores, breakdowns & fix suggestions |
| `canva_db.sql` | 🗄️ A MySQL database that stores the same audit data in proper tables |

---

## 🎯 What This Project Does

This project analyzes a website across **4 key areas** and gives it a health score out of 100 💯:

| Category | Emoji | What It Checks |
|---|---|---|
| ⚡ Performance | 🚀 | How fast the site loads |
| ♿ Accessibility | 🧑‍🦯 | How usable it is for everyone |
| ✅ Best Practices | 🔒 | Security & coding standards |
| 🔍 SEO | 📈 | How well it ranks on search engines |

Then it goes **3 levels deep** 🔽 to explain *exactly* why the score is what it is — down to individual technical metrics.

---

## 🏆 Overall Result

```
🌍 Website:        https://www.canva.in/
⭐ Overall Score:  87 / 100
🟢 Status:         Good
```

| ID | Category | ⚖️ Weight | 🎯 Score | 🚦 Status |
|---|---|---|---|---|
| C1 | ⚡ Performance | 25% | 60.1 | 🟠 Needs Improvement |
| C2 | ♿ Accessibility | 25% | 96.0 | 🟢 Excellent |
| C3 | ✅ Best Practices | 25% | 90.5 | 🟢 Good |
| C4 | 🔍 SEO | 25% | 100.0 | 🟢 Excellent |
| **OVR** | **🏁 Overall** | **100%** | **87.0** | **🟢 Good** |

---

## 🔽 The 3-Level Drill-Down System

Think of it like zooming into a map 🗺️ — each level gets more detailed.

```
🥇 LEVEL 1 — Category Score        (e.g. "Performance = 60.1")
   └─ 🥈 LEVEL 2 — Sub-Factor Score   (e.g. "LCP = 54.3")
        └─ 🥉 LEVEL 3 — Raw Factor    (e.g. "Server Response Time = 420ms ⚠️")
```

### 🥇 Level 1 — Categories
The 4 big buckets shown in the table above ☝️

### 🥈 Level 2 — Sub-Factors
Each category breaks into smaller pieces, for example:

| ⚡ Performance Sub-Factors | Score |
|---|---|
| 🖼️ Largest Contentful Paint (LCP) | 54.3 |
| ⏱️ Total Blocking Time (TBT) | 37.7 |
| 📐 Cumulative Layout Shift (CLS) | 100.0 |
| 🎨 First Contentful Paint (FCP) | 70.0 |
| 🏎️ Speed Index | 44.0 |

*(similar breakdowns exist for ♿ Accessibility, ✅ Best Practices, 🔍 SEO)*

### 🥉 Level 3 — Individual Factors
The most granular metrics, each with a pass/fail flag:

| Factor | Value | Target | Status |
|---|---|---|---|
| 🕐 Server Response Time | 420ms | < 200ms | ⚠️ Fix |
| 📦 Resource Load Time | 780ms | < 500ms | ⚠️ Fix |
| 🧵 Long Tasks | 8 | 0 | ⚠️ Fix |
| 🖼️ Images Without Dimensions | 0 | 0 | ✅ OK |
| 🔐 HTTPS Enabled | Yes | Yes | ✅ OK |

---

## 🛠️ The Fix-It Guide (`INSIGHT` Sheet)

This is the **best part** 🌟 — every performance issue comes with a real, ready-to-use SQL fix!

| 🚩 Issue | Priority | Fix Technique | Impact |
|---|---|---|---|
| 🔴 Render-blocking Requests | High | Select only needed columns + Index | ⚡ 30–60% faster |
| 🔴 Forced Reflow | High | JOIN + Batch Fetch | 📉 Fewer DB calls |
| 🔴 LCP Request Discovery | High | Prioritize hero banner load | 🖼️ Faster LCP |
| 🟠 Cache Lifetimes | Medium | Redis/Django caching | 🚀 70–90% fewer DB hits |
| 🟠 Image Delivery | Medium | WebP + CDN + Lazy Load | 🗜️ 30–70% smaller images |
| ⚪ DOM Size | Low | Pagination | 🧹 Lighter HTML |

Each row includes a real **before ❌ / after ✅** SQL query example, e.g.:

```sql
-- ❌ Before (slow)
SELECT * FROM products;

-- ✅ After (optimized)
SELECT product_id, product_name, price, image_url 
FROM products 
WHERE status='ACTIVE' 
LIMIT 20;
```

---

## 🗄️ Database Structure (`canva_db.sql`)

The audit data is stored in **4 connected tables** 🔗:

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

### ▶️ How to Run It
```bash
mysql -u your_username -p < canva_db.sql
```

---

## 🧩 How Everything Connects

```
📊 Spreadsheet (for humans to read)   🔄   🗄️ Database (for apps to query)
        Sheet2 = Levels 1-3          ⬌      categories → sub_factors → factors
        Sheet3 = Data Dictionary     ⬌      table/column definitions
        INSIGHT = Fix Guide          ⬌      real-world query optimization examples
```

---

## ✅ Quick Summary

- 🎯 **What:** A full website health audit (Performance, Accessibility, Best Practices, SEO)
- 📊 **Score:** 87/100 — Good, with Performance needing the most work 🔧
- 🗄️ **Storage:** 4-table MySQL database mirroring the audit hierarchy
- 🛠️ **Bonus:** Ready-to-use SQL optimization fixes for every performance issue

---

💬 *Got questions? Every metric in this project traces back through Level 1 → 2 → 3, so you can always find exactly where a score came from!* 🔍

---

## 👤 Author

**SHRUTI KADIYA** 
- 🔗 LinkedIn: https://www.linkedin.com/in/shruti-kadiya-677818419/ 
- 💻 GitHub: https://github.com/9Shruti
