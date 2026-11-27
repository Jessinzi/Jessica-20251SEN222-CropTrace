/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group 1
Project Name: CropTrace
*/

-- Indexes on Foreign Keys (To speed up joins and parent deletes)
CREATE INDEX idx_batch_region ON batch(region) TABLESPACE croptrace_idx;
CREATE INDEX idx_quality_batch ON quality_check(batch_id) TABLESPACE croptrace_idx;
CREATE INDEX idx_logistics_batch ON logistics(batch_id) TABLESPACE croptrace_idx;
CREATE INDEX idx_storage_batch ON storage(batch_id) TABLESPACE croptrace_idx;
CREATE INDEX idx_performance_batch ON performance(batch_id) TABLESPACE croptrace_idx;

-- Composite Index (To speed up searching by crop and season together)
CREATE INDEX idx_batch_crop_season ON batch(crop_type, season) TABLESPACE croptrace_idx;

-- Function-Based Index (To speed up case-insensitive searches on stage)
CREATE INDEX idx_batch_stage_upper ON batch(UPPER(supply_chain_stage)) TABLESPACE croptrace_idx;
