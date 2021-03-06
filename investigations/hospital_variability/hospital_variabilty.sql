--What hospitals are models of high-quality care—that is, 
--which hospitals have the most consistently high scores for a variety of procedures?
--What states are models of high-quality care?
--Which procedures have the greatest variability between hospitals?
--Are average scores for hospital quality or procedural variability 
--correlated with patient survey responses?
set hive.cli.print.header=true;

CREATE TEMPORARY TABLE st_hospital_redux AS
SELECT 
hospital_name,
provider_id
FROM 
st_hospital_d 
GROUP BY hospital_name,
provider_id;

CREATE TEMPORARY TABLE st_measures_redux AS
SELECT 
measure_name,
measure_id
FROM 
st_procedures_d
GROUP BY measure_name,
measure_id;



DROP TABLE st_var_procedures;
CREATE TABLE st_var_procedures AS
SELECT 
a.measure_name,
MAX(a.avg_score)-MIN(a.avg_score) as score_range
FROM
(
SELECT
b.hospital_name,
c.measure_name,
a.category,
FLOOR(COUNT(IF(a.score>0,1,0))) as num_p,
FLOOR(AVG(a.score)) as avg_score,
FLOOR(var_samp(a.score)) score_variance

FROM 
st_measures_f as a
LEFT JOIN st_hospital_redux as b ON (a.provider_id = b.provider_id)
LEFT JOIN st_measures_redux as c ON (a.measure_id = c.measure_id)
WHERE a.category = 'effectiveness' 
GROUP BY B.hospital_name, c.measure_name, a.category) AS a
GROUP BY a.measure_name ORDER BY score_range DESC;


SELECT * FROM st_var_procedures  LIMIT 10;