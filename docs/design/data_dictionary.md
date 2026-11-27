# Phase IV Data Dictionary

## Table Justifications
*   **REGION_CLIMATE:** Exists to store environmental data per region. Removes transitive dependency (`temp_avg` depends on `region`, not `batch_id`).
*   **CROP_SEASON_COST:** Exists to store economic data. Removes transitive dependency (`input_cost` depends on `crop_type` and `season`).
*   **BATCH:** The core transactional table. Tracks each harvest batch.
*   **QUALITY_CHECK:** Tracks spoilage and moisture for a batch.
*   **LOGISTICS:** Tracks transport data for a batch.
*   **STORAGE:** Tracks how long a batch is stored.
*   **PERFORMANCE:** Tracks market and resilience metrics.

## Data Dictionary

| Table | Column | Data Type | Null? | Constraint | Why / Description |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **REGION_CLIMATE** | region | VARCHAR2(50) | No | PK | Unique identifier for the region |
| | temp_avg | NUMBER(5,2) | No | | Average temperature of the region |
| | climate_risk | VARCHAR2(20) | No | | Climate risk level (High, Medium, Low) |
| **CROP_SEASON_COST**| crop_type | VARCHAR2(50) | No | PK (Composite) | Type of crop |
| | season | VARCHAR2(20) | No | PK (Composite) | Harvest season |
| | input_cost | NUMBER(10,2) | No | | Cost of inputs for this crop/season |
| **BATCH** | batch_id | VARCHAR2(50) | No | PK | Unique identifier for the harvest batch |
| | crop_type | VARCHAR2(50) | No | FK → CROP_SEASON_COST | Links batch to crop/season data |
| | season | VARCHAR2(20) | No | FK → CROP_SEASON_COST | Links batch to crop/season data |
| | region | VARCHAR2(50) | No | FK → REGION_CLIMATE | Links batch to its origin region |
| | yield_quantity_kg | NUMBER(10,2) | No | CHECK > 0 | Weight of the batch in kg |
| | supply_chain_stage | VARCHAR2(50) | No | | Current stage of the batch |
| **QUALITY_CHECK** | check_id | NUMBER GENERATED ALWAYS AS IDENTITY | No | PK | Surrogate key for the quality check |
| | batch_id | VARCHAR2(50) | No | FK → BATCH | Links test to a specific batch |
| | moisture_avg | NUMBER(5,2) | No | | Average moisture percentage |
| | quality_grade | VARCHAR2(10) | Yes | | Grade of the crop (A, B, C) |
| | spoilage_loss_pct | NUMBER(5,2) | No | CHECK (0 to 100) | Percentage of crop lost to spoilage |
| **LOGISTICS** | logistics_id | NUMBER GENERATED ALWAYS AS IDENTITY | No | PK | Surrogate key for transport record |
| | batch_id | VARCHAR2(50) | No | FK → BATCH | Links transport to a specific batch |
| | equipment | VARCHAR2(50) | Yes | | Transport equipment used |
| | transport_delay_hrs | NUMBER(5,2) | No | CHECK >= 0 | Delay time in hours |
| | logistics_efficiency | NUMBER(5,2) | No | | Efficiency score of the transport |
| **STORAGE** | storage_id | NUMBER GENERATED ALWAYS AS IDENTITY | No | PK | Surrogate key for storage record |
| | batch_id | VARCHAR2(50) | No | FK → BATCH | Links storage to a specific batch |
| | storage_duration_days | NUMBER(5,0) | No | | How long the batch was stored |
| **PERFORMANCE** | performance_id | NUMBER GENERATED ALWAYS AS IDENTITY | No | PK | Surrogate key for performance metrics |
| | batch_id | VARCHAR2(50) | No | FK → BATCH | Links metrics to a specific batch |
| | resilience_score | NUMBER(5,2) | Yes | | Supply chain resilience score |
| | resource_efficiency | NUMBER(5,2) | Yes | | Resource use efficiency score |
| | final_market_price | NUMBER(10,2) | Yes | CHECK > 0 | Price at the market |
| | model_used | VARCHAR2(50) | Yes | | Model used for prediction |
