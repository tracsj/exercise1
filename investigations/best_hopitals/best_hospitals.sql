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


DROP TABLE st_best_hospitals;
CREATE TABLE st_best_hospitals AS
SELECT 
b.hospital_name,
a.category,
FLOOR(COUNT(IF(a.score>0,1,0))) as num_p,
FLOOR(SUM(a.score)) as agg_score,
FLOOR(AVG(a.score)) as avg_score,
FLOOR(var_samp(a.score)) score_variance

FROM 
st_measures_f as a
LEFT JOIN st_hospital_redux as b ON (a.provider_id = b.provider_id)
WHERE a.category = 'effectiveness' 
GROUP BY B.hospital_name, a.category ORDER BY avg_score DESC;


SELECT * FROM st_best_hospitals  WHERE num_p >5 LIMIT 10;




