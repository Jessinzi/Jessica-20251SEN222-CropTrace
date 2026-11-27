/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group 1
Project Name: CropTrace
*/

-- Primary Keys
ALTER TABLE region_climate ADD CONSTRAINT pk_region_climate PRIMARY KEY (region);
ALTER TABLE crop_season_cost ADD CONSTRAINT pk_crop_season_cost PRIMARY KEY (crop_type, season);
ALTER TABLE batch ADD CONSTRAINT pk_batch PRIMARY KEY (batch_id);
ALTER TABLE quality_check ADD CONSTRAINT pk_quality_check PRIMARY KEY (check_id);
ALTER TABLE logistics ADD CONSTRAINT pk_logistics PRIMARY KEY (logistics_id);
ALTER TABLE storage ADD CONSTRAINT pk_storage PRIMARY KEY (storage_id);
ALTER TABLE performance ADD CONSTRAINT pk_performance PRIMARY KEY (performance_id);

-- Foreign Keys with Referential Actions (Task 4)
ALTER TABLE batch ADD CONSTRAINT fk_batch_region FOREIGN KEY (region) REFERENCES region_climate(region) ON DELETE NO ACTION;
ALTER TABLE batch ADD CONSTRAINT fk_batch_crop FOREIGN KEY (crop_type, season) REFERENCES crop_season_cost(crop_type, season) ON DELETE NO ACTION;

ALTER TABLE quality_check ADD CONSTRAINT fk_quality_batch FOREIGN KEY (batch_id) REFERENCES batch(batch_id) ON DELETE CASCADE;
ALTER TABLE storage ADD CONSTRAINT fk_storage_batch FOREIGN KEY (batch_id) REFERENCES batch(batch_id) ON DELETE CASCADE;

ALTER TABLE logistics ADD CONSTRAINT fk_logistics_batch FOREIGN KEY (batch_id) REFERENCES batch(batch_id) ON DELETE SET NULL;
ALTER TABLE performance ADD CONSTRAINT fk_performance_batch FOREIGN KEY (batch_id) REFERENCES batch(batch_id) ON DELETE NO ACTION;

-- Check Constraints
ALTER TABLE batch ADD CONSTRAINT ck_batch_yield CHECK (yield_quantity_kg > 0);
ALTER TABLE quality_check ADD CONSTRAINT ck_quality_spoilage CHECK (spoilage_loss_pct BETWEEN 0 AND 100);
ALTER TABLE logistics ADD CONSTRAINT ck_logistics_delay CHECK (transport_delay_hrs >= 0);
ALTER TABLE performance ADD CONSTRAINT ck_performance_price CHECK (final_market_price > 0);
