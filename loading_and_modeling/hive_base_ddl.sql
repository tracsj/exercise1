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
LOCATION "/hdfs/";

LOAD DATA LOCAL INPATH 'hospitals.csv'
OVERWRITE INTO TABLE Web_Session_Log;

CREATE VIEW st_hospitals_fitler AS SELECT A, C, F FROM ext_table;


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
    measure_end DATE,
    PRIMARY KEY (provider_id, measure_id))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION ‘/hdfs//effective_care.csv’;

-- Create measures table
DROP TABLE st_measures;
CREATE EXTERNAL TABLE st_measures (
    measure_name STRING,
    measure_id STRING,
    measure_start_quarter DATE,
    measure_start DATE,
    measure_end_quarter DATE,
    measure_end DATE,
    PRIMARY KEY (measure_id))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION ‘/hdfs//measures.csv’;


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
    measure_end DATE,
    PRIMARY KEY (provider_id, measure_id))
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
   "separatorChar" = ",",
   "quoteChar"     = '"',
   "escapeChar"    = '\\'
)
STORED AS TEXTFILE
LOCATION ‘/hdfs//readmissions.csv’;



**surveys_responses.csv**
Provider Number,Hospital Name,Address,City,State,ZIP Code,County Name,Communication with Nurses Achievement Points,Communication with Nurses Improvement Points,Communication with Nurses Dimension Score,Communication with Doctors Achievement Points,Communication with Doctors Improvement Points,Communication with Doctors Dimension Score,Responsiveness of Hospital Staff Achievement Points,Responsiveness of Hospital Staff Improvement Points,Responsiveness of Hospital Staff Dimension Score,Pain Management Achievement Points,Pain Management Improvement Points,Pain Management Dimension Score,Communication about Medicines Achievement Points,Communication about Medicines Improvement Points,Communication about Medicines Dimension Score,Cleanliness and Quietness of Hospital Environment Achievement Points,Cleanliness and Quietness of Hospital Environment Improvement Points,Cleanliness and Quietness of Hospital Environment Dimension Score,Discharge Information Achievement Points,Discharge Information Improvement Points,Discharge Information Dimension Score,Overall Rating of Hospital Achievement Points,Overall Rating of Hospital Improvement Points,Overall Rating of Hospital Dimension Score,HCAHPS Base Score,HCAHPS Consistency Score