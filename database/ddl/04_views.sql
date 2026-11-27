/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group 1
Project Name: CropTrace
*/

-- 1. Reporting View: Joins several tables into one readable result
CREATE OR REPLACE VIEW vw_batch_details AS
SELECT 
    b.batch_id, 
    b.crop_type, 
    b.region, 
    r.climate_risk,
    b.yield_quantity_kg, 
    q.quality_grade, 
    q.spoilage_loss_pct
FROM batch b
JOIN region_climate r ON b.region = r.region
JOIN quality_check q ON b.batch_id = q.batch_id;

-- 2. Summary View: Uses GROUP BY (Totals per region)
CREATE OR REPLACE VIEW vw_region_summary AS
SELECT 
    region, 
    COUNT(batch_id) AS total_batches, 
    SUM(yield_quantity_kg) AS total_yield_kg,
    ROUND(AVG(spoilage_loss_pct), 2) AS avg_spoilage
FROM batch b
JOIN quality_check q USING (batch_id)
GROUP BY region;

-- 3. Protected View: WITH READ ONLY (Prevents anyone from changing data through the view)
CREATE OR REPLACE VIEW vw_readonly_performance AS
SELECT performance_id, batch_id, final_market_price, model_used
FROM performance
WITH READ ONLY;
