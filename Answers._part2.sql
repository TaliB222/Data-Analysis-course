--  * Home assignment *
------------------
-- patients with 5 active distinct medications:
SELECT medications.c1 as patients_ID, demography.c2 as First_N, demography.c3 as Last_N
FROM medications
JOIN demography on medications.c1 = demography.c1
WHERE medications.c5 is 'ACTIVE'
GROUP BY medications.c1
HAVING COUNT( DISTINCT medications.c2) =5
order BY medications.c1
---	patiensts with at least one medication has a PGx guideline:
SELECT medications.c1 AS pateint_ID, COUNT( DISTINCT guidelines.c1) as count_guidline_id
from medications
LEFT join guidelines ON medications.c3 = guidelines.c2
GROUP BY medications.c1
HAVING count_guidline_id >=1
ORDER BY medications.c1 

--both risks criterais,  high risk patients:
SELECT medications.c1 as patients_ID, demography.c2 as First_N, demography.c3 as Last_N, COUNT( DISTINCT guidelines.c1) as count_guidline_id
FROM medications
JOIN demography on medications.c1 = demography.c1
LEFT join guidelines ON medications.c3 = guidelines.c2
WHERE medications.c5 is 'ACTIVE'
GROUP BY medications.c1
HAVING COUNT( DISTINCT medications.c2) =5 and count_guidline_id >=1
order BY medications.c1
--with age:
SELECT medications.c1 as patients_ID, demography.c2 as First_N, demography.c3 as Last_N,
COUNT(DISTINCT guidelines.c1) AS count_guidline_id, demography.c4 as age
FROM medications
JOIN demography on medications.c1 = demography.c1
LEFT join guidelines ON medications.c3 = guidelines.c2
WHERE medications.c5 is 'ACTIVE' 
GROUP BY medications.c1
HAVING COUNT( DISTINCT medications.c2) =5 and count_guidline_id >=1
order BY medications.c1
-- with age criteria:
SELECT medications.c1 as patients_ID, demography.c2 as First_N, demography.c3 as Last_N,
COUNT(DISTINCT guidelines.c1) AS count_guidline_id, demography.c4 as age, 
(case 
when demography.c4>20 and demography.c4<40 THEN 'low risk'
else 'high risk'
end) as 'age_criteria'
FROM medications 
JOIN demography on medications.c1 = demography.c1
LEFT join guidelines ON medications.c3 = guidelines.c2
WHERE medications.c5 is 'ACTIVE' 
GROUP BY medications.c1
HAVING COUNT( DISTINCT medications.c2) =5 and count_guidline_id >=1
order BY medications.c1
-- total number of distinct medications for each patients:
SELECT demography.c1 AS pateint_ID, demography.c2 as patients_First_N, 
demography.c3 as patients_Last_N, COUNT( DISTINCT medications.c2) as distinct_med
from demography
LEFT join medications ON demography.c1 = medications.c1
GROUP BY medications.c1
ORDER BY medications.c1
---	A list of the patients PGx medications (medications with guidelines)
SELECT medications.c1 AS pateint_ID, COUNT( DISTINCT guidelines.c1) as count_guidline_id
from medications
LEFT join guidelines ON medications.c3 = guidelines.c2
GROUP BY medications.c1
--HAVING count_guidline_id >=1
ORDER BY medications.c1 
-- severity for each medication:
SELECT medications.c1 AS pateint_ID, medications.c2 as medication_ID, guidelines.c1 as guidline_id, guidelines.c2 as ingredient_id, guidelines.c4 as severity
from medications
LEFT join guidelines ON medications.c3 = guidelines.c2
--GROUP BY medications.c1
--HAVING count_guidline_id >=1
ORDER BY medications.c1 

--
SELECT medications.c1 AS pateint_ID, medications.c2 as medication_ID, guidelines.c1 as guidline_id, guidelines.c2 as ingredient_id, guidelines.c4 as severity
from medications
LEFT join guidelines ON medications.c3 = guidelines.c2
GROUP BY medications.c2
--HAVING count_guidline_id >=1
ORDER BY medications.c1 