-- Question 1- How many male have responded to the survey from india?
select * from personalized_info;

select count(ResponseID) as male_count
from personalized_info
where Gender like 'Male%' and CurrentCountry like 'India%';
-- There are total of 1733 males from India who have responded to the survey.

--   Question 2- How many female have responded to the survey from India?
select count(ResponseID) as female_count
from personalized_info
where Gender like 'Female%' and CurrentCountry like 'India%';
-- There are total of 1181 females from India who have responded to the survey.

--  question 3- How many GenZ are influenced by their parents in regards to their career choices from India?
select count(la.ResponseID) as count_of_GenZ
from learning_aspirations as la
inner join personalized_info as pa
on la.ResponseID=pa.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%';
--  There are 443 GenZ from India who are affected by their parents while selecting career choice.

-- Question 4 How many female Genz are influenced by their parents in regards to their career choices from India?
select count(la.ResponseID) as Female_count
from learning_aspirations as la
inner join personalized_info as pa
on la.ResponseID=pa.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%' and Gender like'Female%';
--  There are total of 187 females who are affected by their parents in India

-- Question 5 How manymale Genz are influenced by their parents in regards to their career choices from India?
select count(la.ResponseID) as male_count
from learning_aspirations as la
inner join personalized_info as pa
on la.ResponseID=pa.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like 'India%' and Gender like'male%';
--  There are total of 256males who are affected by their parents in India

--  Question 6 How many male and female are affected by their parents choices in India ?
select SUM(CASE WHEN Gender LIKE 'Male%' THEN 1 ELSE 0 END) AS Male_GenZ_Affectedby_Parents,
    SUM(CASE WHEN Gender LIKE 'Female%' THEN 1 ELSE 0 END) AS Female_GenZ_Affectedby_Parents
from learning_aspirations as la
inner join personalized_info as pa
on la.ResponseID=pa.ResponseID
where CareerInfluenceFactor like 'My Parents%' and CurrentCountry like'India%';
-- There are total of 256 males and 187 females affected by their parents.

 -- Question 7 How many GenZ are affected by Media and Influencers together in India?
 select count(pa.ResponseID) as affected_GenZ
 from learning_aspirations as la
 inner join personalized_info as pa
 on la.ResponseID=pa.ResponseID
 where CurrentCountry like 'India%' and CareerInfluenceFactor in ('Social Media%' and 'Influencers%');
 --  There are total of 1233 GenZ who are affected by Social Media platforms and Infliencers in India.
 
 --  Question 8 How many GenZ are affected by Media and Influencers together in India for both male and female?
 SELECT
    SUM(CASE WHEN Gender LIKE 'Male%' THEN 1 ELSE 0 END) AS Male_GenZ_Affectedby_Parents,
    SUM(CASE WHEN Gender LIKE 'Female%' THEN 1 ELSE 0 END) AS Female_GenZ_Affectedby_Parents
FROM learning_aspirations
INNER JOIN personalized_info
ON learning_aspirations.ResponseID = personalized_info.ResponseID 
WHERE  CurrentCountry LIKE 'India%' and CareerInfluenceFactor in ('Social Media%' and 'Influencers%');
-- There are total of 727 male and 496 female who are affected by Social media and Influencers in India.

-- Question 9 - How many of GenZ who are influenced by Social media and are willing to go abroad?
select count(ResponseID) as Genz
from learning_aspirations
where CareerInfluenceFactor like 'Social Media%' and  HigherEducationAbroad like 'Yes%';
-- there are total of 56 GenZ who want to go abroad and are affected by social media

-- Question 10  How many Genz are Influenced by 'people in their circle' and are looking to go abroad?
select count(ResponseID) as count
from learning_aspirations
where CareerInfluenceFactor like 'People from my circle%' and HigherEducationAbroad like'Yes%';
--  there are total of 67 individuals who want to go abroad and are affected by people in their circle.
-- 
