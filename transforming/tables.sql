-- st_hospitals
-- st_effectivness
-- st_measures
-- st_readmissions
-- st_surveys
-- Copy this file to EC2
-- scp -i ~/Downloads/205_key.pem  ~/Documents/git/exercise1/transforming/tables.sql root@ec2-52-23-170-66.compute-1.amazonaws.com:/user/root/hospital_compare

--Create Hospitaltable
DROP TABLE st_hospital_d;
CREATE TABLE st_hospital_d AS 
SELECT
  provider_id,
  hospital_name,
  state,
  city
FROM
  st_hospitals
;

--Create Procedures table
DROP TABLE st_procedures_d;
CREATE TABLE st_procedures_d AS 
SELECT
  measure_name,
  measure_id,
  measure_start,
  measure_end
FROM
  st_measures;

--Create Measures table
DROP TABLE st_measures_f;
CREATE TABLE st_measures_f AS 
SELECT
  provider_id,
  measure_id,
  score,
  sample as denominator,
  'effectiveness' as category,
  NULL as low_estimate,
  NULL as high_estimate
FROM
  st_effectivness
WHERE  score <> 'not_available' AND score <> 'Not Available'

UNION ALL

SELECT
  provider_id,
  measure_id,
  score,
  sample as denominator,
  'readmissions' as category,
  low_estimate,
  high_estimate
FROM
  st_readmissions

WHERE score <> 'not_available' AND score <> 'Not Available'
;

SELECT * FROM st_measures_f WHERE provider_id = 051335;


--Create Surveys table
DROP TABLE st_surveys_f;
CREATE TABLE st_surveys_f AS 
SELECT
  provider_id,
  score_25 base_score,
  score_26 consistency_score
FROM
  st_surveys;
