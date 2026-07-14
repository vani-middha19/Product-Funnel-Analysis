# 🛒 Mobile Shopping App: Funnel Analysis & Drop-off Optimization

## 📊 Executive Summary
The acquisition funnel for the mobile app is highly effective during product discovery, maintaining a 100% conversion rate from App Open to Product View. However, the most critical bottleneck occurs at the final stage: **33.3% of users who reach checkout abandon their cart before purchasing.** 

This project analyzes the user journey to identify friction points and provides strategic recommendations to improve the overall 40% conversion rate.

## 🎯 Business Problem
**The Prompt:** "Users seem to be dropping off before purchasing. Can you identify where they're leaving the funnel and recommend improvements?"

**Goal:** Analyze the end-to-end user journey, identify the highest drop-off points, and formulate data-backed hypotheses for product interventions.

## 🛠️ Tech Stack & Methodology
- **Data Querying & Aggregation:** SQL
- **Data Cleaning & Initial Validation:** Microsoft Excel
- **Data Visualization & Executive Reporting:** Power BI
- **KPIs Tracked:** DAU, MAU, Funnel Conversion Rate, Cart Abandonment Rate, AOV.

## 📈 Funnel Analysis & Findings

| Funnel Stage | Users | Conversion from Previous Stage | Drop-off Rate |
| :--- | :--- | :--- | :--- |
| **App Open** | 5 | - | 0% |
| **Product View** | 5 | 100% | 0% |
| **Add to Cart** | 4 | 80% | 20% |
| **Checkout** | 3 | 75% | 25% |
| **Purchase** | 2 | 66.7% | **33.3%** |

*Overall Conversion Rate (App Open to Purchase): 40%*

### Key Insight
The highest percentage of user abandonment (**33.3%**) occurs during the transition from **Checkout to Purchase**. Users demonstrate strong purchase intent by building carts, but encounter significant friction during final order completion.

## 💡 Strategic Recommendations & Next Steps

Based on the funnel bottleneck, the immediate business focus must shift to optimizing the checkout flow. 

**Working Hypotheses for Checkout Friction:**
1. Lengthy or multi-page checkout flow causing fatigue.
2. Unexpected costs revealed at checkout (e.g., high shipping fees).
3. Limited payment options (lack of Apple Pay, Google Pay, or localized options).
4. Technical failures or slow payment processing times.

**Proposed Next Steps for the Product Team:**
- **Data Deep-Dive:** Segment the checkout drop-off data by device type (iOS vs. Android) and payment method to isolate potential technical bugs.
- **Funnel Expansion:** Implement tracking for payment failure rates and checkout completion time.
- **UX Intervention:** A/B test a simplified, single-page checkout flow or introduce guest checkout to reduce necessary input fields.
