--What hospitals are models of high-quality care—that is, 
--which hospitals have the most consistently high scores for a variety of procedures?
--What states are models of high-quality care?
--Which procedures have the greatest variability between hospitals?
--Are average scores for hospital quality or procedural variability 
--correlated with patient survey responses?
set hive.cli.print.header=true;

CREATE TEMPORARY TABLE st_states_redux AS
SELECT 
state,
provider_id
FROM 
st_hospital_d 
GROUP BY state,
provider_id;

/* check to look at tsome of the raw score data
SELECT 
* 
FROM
st_measures_f as a
LEFT JOIN st_states_redux as b ON (a.provider_id = b.provider_id)
WHERE a.category = 'effectiveness'  AND b.state = 'MD'
LIMIT 50;
*/

DROP TABLE st_best_states;
CREATE TABLE st_best_states AS
SELECT 
b.state,
a.category,
FLOOR(COUNT(IF(a.score>0,1,0))) as num_p,
FLOOR(SUM(a.score)) as agg_score,
FLOOR(AVG(a.score)) as avg_score,
FLOOR(var_samp(a.score)) score_variance

FROM 
st_measures_f as a
LEFT JOIN st_states_redux as b ON (a.provider_id = b.provider_id)
WHERE a.category = 'effectiveness' 
GROUP BY B.state, a.category ORDER BY avg_score DESC;


SELECT * FROM st_best_states LIMIT 10;




