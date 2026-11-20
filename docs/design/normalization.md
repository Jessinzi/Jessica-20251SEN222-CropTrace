# Phase II: Normalization and Entity Identification

## Task 3: Entity Identification and Relationships
The raw CSV contains all data in one flat file. To turn this into a relational database, we identify the hidden entities (nested objects and repeated values) and split them into related tables. 

1. **`BATCH` (Core Entity):** Represents the main transaction. Contains `batch_id` (Primary Key), `crop_type`, `region`, `season`, `yield_quantity_kg`, `supply_chain_stage`.
2. **`REGION_CLIMATE` (Reference Entity):** The climate data depends on the region. Contains `region` (Primary Key), `temp_avg`, `climate_risk`.
3. **`CROP_ECONOMICS` (Reference Entity):** The input cost depends on the crop type and season. Contains `crop_type` and `season` (Composite Primary Key), `input_cost`.
4. **`QUALITY_CHECK` (Child Entity):** Separates quality metrics from the main batch. Contains `quality_id` (Primary Key), `batch_id` (Foreign Key), `moisture_avg`, `quality_grade`, `spoilage_loss`.
5. **`LOGISTICS` (Child Entity):** Separates transport data. Contains `logistics_id` (Primary Key), `batch_id` (Foreign Key), `equipment`, `transport_delay_hrs`, `logistics_efficiency`.
6. **`STORAGE` (Child Entity):** Separates storage time. Contains `storage_id` (Primary Key), `batch_id` (Foreign Key), `storage_duration_days`.
7. **`PERFORMANCE` (Child Entity):** Separates the final market metrics. Contains `performance_id` (Primary Key), `batch_id` (Foreign Key), `resilience_score`, `resource_efficiency`, `final_market_price`, `model_used`.

**Relationships (Cardinality):**
*   One `REGION_CLIMATE` has Many `BATCHES` (1:N)
*   One `CROP_ECONOMICS` has Many `BATCHES` (1:N)
*   One `BATCH` has One `QUALITY_CHECK` (1:1)
*   One `BATCH` has One `LOGISTICS` record (1:1)
*   One `BATCH` has One `STORAGE` record (1:1)
*   One `BATCH` has One `PERFORMANCE` record (1:1)

---

## Task 4: Normalization Process

### 1. Unnormalized Form (UNF)
The raw data is a single flat CSV file containing all information about the batch, environment, logistics, and quality. 
**Sample Rows (3 rows):**

| batch_id | crop_type | region | season | yield_quantity_kg | temp_avg | input_cost | spoilage_loss_% | equipment | transport_delay_hrs |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| BATCH001 | Maize | East | Rabi | 605.99 | 28.3 | 4.4 | 3.17 | 2 | 0.2 |
| BATCH002 | Barley | West | Kharif | 561.7 | 26.54 | 9.13 | 2.44 | 27 | 1.9 |
| BATCH003 | Wheat | South | Kharif | 568.36 | 32.13 | 7.93 | 9.49 | 28 | 0.7 |

*   **Dependency Removed:** None yet. The data is unnormalized and contains data redundancy.

### 2. First Normal Form (1NF)
**Rule:** Remove repeating groups; every column must hold a single (atomic) value.
**Sample Rows:** The table remains the same as UNF.
*   **Dependency Removed:** There are no repeating groups (e.g., no multiple phone numbers in one cell), so the dataset is already in 1NF.

### 3. Second Normal Form (2NF)
**Rule:** Remove partial dependencies (all non-key columns must depend entirely on the primary key).
**Sample Rows:** The table remains the same as UNF.
*   **Dependency Removed:** There are no partial dependencies because the primary key is a single column (`batch_id`). Every column depends entirely on the batch.

### 4. Third Normal Form (3NF)
**Rule:** Remove transitive dependencies (non-key columns must not depend on other non-key columns).
**Action:** We split the table into 7 tables. Here is the dependency removed for each split:

**1. `REGION_CLIMATE` Table**
*   **Dependency Removed:** Removed transitive dependency: `temp_avg` and `climate_risk` depend on the `region`, not the specific `batch_id`.

**2. `CROP_SEASON_COST` Table**
*   **Dependency Removed:** Removed transitive dependency: `input_cost` depends on the `crop_type` and `season`, not the specific `batch_id`.

**3. `QUALITY_CHECK` Table**
*   **Dependency Removed:** Removed transitive dependency: The `quality_grade` depends on the `moisture_avg` and `spoilage_loss_pct` metrics, not directly on the batch itself.

**4. `LOGISTICS` Table**
*   **Dependency Removed:** Removed transitive dependency: `logistics_efficiency` depends on the `equipment` and `transport_delay_hrs`, separating transport data from the core batch.

**5. `STORAGE` Table**
*   **Dependency Removed:** Removed transitive dependency: `storage_duration_days` depends on the storage facility conditions, separating it from the main harvest batch data.

**6. `PERFORMANCE` Table**
*   **Dependency Removed:** Removed transitive dependency: Final performance metrics like `resilience_score` and `final_market_price` are calculated results that depend on the combination of all prior stages, so they are separated.

**The 7th table**
Is the core **`BATCH`** table which holds the primary key `batch_id` and foreign keys linking to these 6 tables.


## 5. Field Mapping 

**Note on Data Dropping:** No raw fields were dropped during this normalization process. Every single column from the raw CSV was relevant to the supply chain tracking and was successfully mapped to one of the 7 target tables below.

| Raw CSV Column | Target Table | Target Column | Type Conversion |
| :--- | :--- | :--- | :--- |
| batch_id | BATCH | batch_id | Text (VARCHAR2) |
| crop_type | BATCH | crop_type | Text (VARCHAR2) |
| region | BATCH | region | Text (VARCHAR2) |
| season | BATCH | season | Text (VARCHAR2) |
| yield_quantity_kg | BATCH | yield_quantity_kg | Number |
| supply_chain_stage | BATCH | supply_chain_stage | Text (VARCHAR2) |
| temp_avg | REGION_CLIMATE | temp_avg | Number |
| climate_risk | REGION_CLIMATE | climate_risk | Text (VARCHAR2) |
| input_cost | CROP_ECONOMICS | input_cost | Number |
| moisture_avg | QUALITY_CHECK | moisture_avg | Number |
| quality_grade | QUALITY_CHECK | quality_grade | Text (VARCHAR2) |
| spoilage_loss | QUALITY_CHECK | spoilage_loss | Number |
| equipment | LOGISTICS | equipment | Text (VARCHAR2) |
| transport_delay_hrs | LOGISTICS | transport_delay_hrs | Number |
| logistics_efficiency | LOGISTICS | logistics_efficiency | Number |
| storage_duration_days | STORAGE | storage_duration_days | Number |
| resilience_score | PERFORMANCE | resilience_score | Number |
| resource_efficiency | PERFORMANCE | resource_efficiency | Number |
| final_market_price | PERFORMANCE | final_market_price | Number |
| model_used | PERFORMANCE | model_used | Text (VARCHAR2) |

# Data Dictionary

| Table | Column Name | Meaning | Required? | Unique? | Key Type |
| :--- | :--- | :--- | :--- | :--- | :--- |
| BATCH | batch_id | Unique identifier for the harvest batch | Yes | Yes | Primary Key |
| BATCH | crop_type | The crop harvested (e.g., Maize) | Yes | No | Foreign Key |
| BATCH | region | Origin region (e.g., East) | Yes | No | Foreign Key |
| BATCH | season | Harvest season (e.g., Rabi) | Yes | No | Foreign Key |
| BATCH | yield_quantity_kg | Weight of the batch in kg | Yes | No | |
| BATCH | supply_chain_stage | Current stage of the batch | Yes | No | |
| REGION_CLIMATE | region | Unique identifier for the region | Yes | Yes | Primary Key |
| REGION_CLIMATE | temp_avg | Average temperature of the region | Yes | No | |
| REGION_CLIMATE | climate_risk | Climate risk level (e.g., High, Medium) | Yes | No | |
| CROP_SEASON_COST | crop_type | Type of crop | Yes | Yes | Composite PK |
| CROP_SEASON_COST | season | Season of harvest | Yes | Yes | Composite PK |
| CROP_SEASON_COST | input_cost | Cost of inputs for this crop/season | Yes | No | |
| QUALITY_CHECK | check_id | Unique identifier for the test | Yes | Yes | Primary Key |
| QUALITY_CHECK | batch_id | Links the test to a specific batch | Yes | No | Foreign Key |
| QUALITY_CHECK | moisture_avg | Average moisture percentage | Yes | No | |
| QUALITY_CHECK | quality_grade | Grade of the crop (A, B, C) | Yes | No | |
| QUALITY_CHECK | spoilage_loss_pct | Percentage of crop lost to spoilage | Yes | No | |
| LOGISTICS | logistics_id | Unique identifier for transport | Yes | Yes | Primary Key |
| LOGISTICS | batch_id | Links transport to a specific batch | Yes | No | Foreign Key |
| LOGISTICS | equipment | Transport equipment used | Yes | No | |
| LOGISTICS | transport_delay_hrs | Delay time in hours | Yes | No | |
| LOGISTICS | logistics_efficiency | Efficiency score of the transport | Yes | No | |
| STORAGE | storage_id | Unique identifier for storage | Yes | Yes | Primary Key |
| STORAGE | batch_id | Links storage to a specific batch | Yes | No | Foreign Key |
| STORAGE | storage_duration_days | How long the batch was stored | Yes | No | |
| PERFORMANCE | performance_id | Unique identifier for metrics | Yes | Yes | Primary Key |
| PERFORMANCE | batch_id | Links metrics to a specific batch | Yes | No | Foreign Key |
| PERFORMANCE | resilience_score | Supply chain resilience score | Yes | No | |
| PERFORMANCE | resource_efficiency | Resource use efficiency score | Yes | No | |
| PERFORMANCE | final_market_price | Price at the market | Yes | No | |
| PERFORMANCE | model_used | Model used for prediction | Yes | No | |
