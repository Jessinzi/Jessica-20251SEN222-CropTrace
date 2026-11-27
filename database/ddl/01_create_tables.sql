/*
Name: Jessica Ishimwe
Student ID: 20251SEN222
Group: Group 1
Project Name: CropTrace
*/

CREATE TABLE region_climate (
    region VARCHAR2(50) NOT NULL,
    temp_avg NUMBER(5,2) NOT NULL,
    climate_risk VARCHAR2(20) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE crop_season_cost (
    crop_type VARCHAR2(50) NOT NULL,
    season VARCHAR2(20) NOT NULL,
    input_cost NUMBER(10,2) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE batch (
    batch_id VARCHAR2(50) NOT NULL,
    crop_type VARCHAR2(50) NOT NULL,
    season VARCHAR2(20) NOT NULL,
    region VARCHAR2(50) NOT NULL,
    yield_quantity_kg NUMBER(10,2) NOT NULL,
    supply_chain_stage VARCHAR2(50) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE quality_check (
    check_id NUMBER GENERATED ALWAYS AS IDENTITY,
    batch_id VARCHAR2(50) NOT NULL,
    moisture_avg NUMBER(5,2) NOT NULL,
    quality_grade VARCHAR2(10),
    spoilage_loss_pct NUMBER(5,2) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE logistics (
    logistics_id NUMBER GENERATED ALWAYS AS IDENTITY,
    batch_id VARCHAR2(50), 
    equipment VARCHAR2(50),
    transport_delay_hrs NUMBER(5,2) NOT NULL,
    logistics_efficiency NUMBER(5,2) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE storage (
    storage_id NUMBER GENERATED ALWAYS AS IDENTITY,
    batch_id VARCHAR2(50) NOT NULL,
    storage_duration_days NUMBER(5,0) NOT NULL
) TABLESPACE croptrace_data;

CREATE TABLE performance (
    performance_id NUMBER GENERATED ALWAYS AS IDENTITY,
    batch_id VARCHAR2(50) NOT NULL,
    resilience_score NUMBER(5,2),
    resource_efficiency NUMBER(5,2),
    final_market_price NUMBER(10,2),
    model_used VARCHAR2(50)
) TABLESPACE croptrace_data;
