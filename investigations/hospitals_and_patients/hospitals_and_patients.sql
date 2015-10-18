--What hospitals are models of high-quality care—that is, 
--which hospitals have the most consistently high scores for a variety of procedures?
--What states are models of high-quality care?
--Which procedures have the greatest variability between hospitals?
--Are average scores for hospital quality or procedural variability 
--correlated with patient survey responses?
set hive.cli.print.header=true;

--Get Hopsital fields needed & combine with patient scores
CREATE TEMPORARY TABLE st_hospital_redux AS
SELECT 
a.hospital_name,
a.provider_id,
b.base_score

FROM 
st_hospital_d a
LEFT JOIN st_surveys_f b ON (a.provider_id = b.provider_id)
GROUP BY a.hospital_name,
a.provider_id,
b.base_score;


--Create scores fro Hospital quality
DROP TABLE st_patients_vs_hospitals;
CREATE TABLE st_patients_vs_hospitals AS
SELECT
corr(a.base_score,a.avg_score) as correlated

FROM (
SELECT 
b.hospital_name,
a.category,
INT(b.base_score) as base_score,
FLOOR(COUNT(IF(a.score>0,1,0))) as num_p,
FLOOR(SUM(a.score)) as agg_score,
FLOOR(AVG(a.score)) as avg_score,
FLOOR(var_samp(a.score)) score_variance

FROM 
st_measures_f as a
LEFT JOIN st_hospital_redux as b ON (a.provider_id = b.provider_id)
WHERE a.category = 'effectiveness' 
GROUP BY B.hospital_name, a.category, b.base_score ORDER BY avg_score DESC)
AS a
;


SELECT * FROM st_patients_vs_hospitals;
