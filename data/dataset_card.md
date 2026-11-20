# Dataset Card: AgriSupplyChainResilience

## 1. Overview
*   **Source Link:** https://www.kaggle.com/datasets/ziya07/agrisupplychainresilience
*   **Licence:** Educational use permitted (Kaggle public dataset).
*   **Format:** CSV (Comma Separated Values).
*   **Size:** 2,000 rows, 20 columns.
*   **Date Collected:** 20th November 2026
*   **What one record represents:** One record represents a single agricultural production batch moving through the supply chain, capturing its yield, environmental conditions, transport delays, and quality metrics.

## 2. Data Quality Report (Counts)

*   **Missing Values:** 0 missing values found in any columns (yield, moisture, spoilage, transport delay). The dataset is highly complete.
*   **Duplicates:** 2 duplicate `batch_id` records found using an Excel formula (`COUNTA - SUMPRODUCT`).
*   **Text/Format Issues:** All columns appear correctly formatted. Numeric values are stored as numbers.
*   **Anomalies & Outliers:** 0 anomalies found. 
*   **Checks performed:** I verified that the `spoilage_loss_%` column contains no negative values and no values over 100%. I verified that `transport_delay_hrs` contains no negative time values. I checked the `crop_type` and `region` columns for spelling variations and found them to be consistent. 
