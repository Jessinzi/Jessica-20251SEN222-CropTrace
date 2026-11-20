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
