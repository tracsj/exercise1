-- Create Hospital Table

DROP TABLE st_hospitals;

CREATE EXTERNAL TABLE st_hospitals (
    provider_id INT,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    tel_num STRING,
    hopsital_type STRING,
    hopsital_ownership STRING,
    emergency_service STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION "/hdfs/hospitals/";


-- CREATE VIEW st_hospitals_filter AS SELECT A, C, F FROM ext_table;


-- Create effectiveness table
DROP TABLE st_effectivness;
CREATE EXTERNAL TABLE st_effectivness (
    provider_id STRING ,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    tel_num STRING,
    condition STRING,
    measure_id STRING,
    measure_name STRING,
    score INT,
    sample INT,
    footnote STRING,
    measure_start DATE,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/hdfs/effective_care/';

-- Create measures table
DROP TABLE st_measures;
CREATE EXTERNAL TABLE st_measures (
    measure_name STRING,
    measure_id STRING,
    measure_start_quarter DATE,
    measure_start DATE,
    measure_end_quarter DATE,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/hdfs/measures/';


-- Create readmissions table
DROP TABLE st_readmissions;
CREATE EXTERNAL TABLE st_readmissions (
    provider_id STRING ,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    tel_num STRING,
    measure_name STRING,
    measure_id STRING,
    compared_to_national STRING,
    sample INT,
    score INT,
    low_estimate  INT,
    high_estimate  INT,
    footnote STRING,
    measure_start DATE,
    measure_end DATE)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/hdfs/readmissions/';

-- Create readmissions table
DROP TABLE st_surveys;
CREATE EXTERNAL TABLE st_surveys (
	provider_id INT,
    hospital_name STRING,
    address STRING,
    city STRING,
    state STRING,
    zip_code STRING,
    county STRING,
    score_1 STRING COMMENT 'Communication with Nurses Achievement Points',
    score_2 STRING COMMENT 'Communication with Nurses Improvement Points',     
    score_3 STRING COMMENT 'Communication with Nurses Dimension Score',     
    score_4 STRING COMMENT 'Communication with Doctors Achievement Points',     
    score_5 STRING COMMENT 'Communication with Doctors Improvement Points',     
    score_6 STRING COMMENT 'Communication with Doctors Dimension Score',     
    score_7 STRING COMMENT 'Responsiveness of Hospital Staff Achievement Points',     
    score_8 STRING COMMENT 'Responsiveness of Hospital Staff Improvement Points',     
    score_9 STRING COMMENT 'Responsiveness of Hospital Staff Dimension Score',     
    score_10 STRING COMMENT 'Pain Management Achievement Points',     
    score_11 STRING COMMENT 'Pain Management Improvement Points',     
    score_12 STRING COMMENT 'Pain Management Dimension Score',     
    score_13 STRING COMMENT 'Communication about Medicines Achievement Points',     
    score_14 STRING COMMENT 'Communication about Medicines Improvement Points',     
    score_15 STRING COMMENT 'Communication about Medicines Dimension Score',     
    score_16 STRING COMMENT 'Cleanliness and Quietness of Hospital Environment Achievement Points',     
    score_17 STRING COMMENT 'Cleanliness and Quietness of Hospital Environment Improvement Points',     
    score_18 STRING COMMENT 'Cleanliness and Quietness of Hospital Environment Dimension Score',     
    score_19 STRING COMMENT 'Discharge Information Achievement Points',     
    score_20 STRING COMMENT 'Discharge Information Improvement Points',     
    score_21 STRING COMMENT 'Discharge Information Dimension Score',     
    score_22 STRING COMMENT 'Overall Rating of Hospital Achievement Points',     
    score_23 STRING COMMENT 'Overall Rating of Hospital Improvement Points',     
    score_24 STRING COMMENT 'Overall Rating of Hospital Dimension Score',     
    score_25 INT COMMENT 'HCAHPS Base Score',
    score_26 INT COMMENT 'HCAHPS Consistency Score')
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION '/hdfs/surveys_responses/';
