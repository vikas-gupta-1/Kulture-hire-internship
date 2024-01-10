use genzdataset;
show tables;
select * from learning_aspirations;
select * from manager_aspirations;
select * from mission_aspirations;
select * from personalized_info;

-- query 1
select 
concat(round(sum(case when gender like 'Male%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as male_percent,
concat(round(sum(case when gender like 'Female%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as female_percent
from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
where PreferredWorkingenvironment like 'Every Day%';
-- there are total of 5% male and 3% female out of total population who wants to go to office everyday.

--  query 2
select concat(round(count(*)/(select count(*) from learning_aspirations)*100,0),'%') as percent
from learning_aspirations
where ClosestAspirationalCareer like 'Business Operations%' and 
CareerInfluenceFactor like 'My Parents%';
--  out of total population 7% GenZ are influenced by their parents and aspired to be in business operations.

-- Query 3
select 
concat(round(sum(case when gender like 'Male%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as male_percent,
concat(round(sum(case when gender like 'Female%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as female_percent
from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
where HigherEducationAbroad like 'yes%';
--  out of total population 12% male and 8% female wants to go abroad for higher studies.

--  query 4 
select gender,
concat(round(sum(case when misalignedmissionlikelihood like 'will not work for them%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as willnotworkforthem,
concat(round(sum(case when misalignedmissionlikelihood like 'will work for them%' then 1 else 0 end)/(select count(*) from personalized_info)*100,0),'%') as willworkforthem
from mission_aspirations as ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where MissionUndefinedLikelihood like 'No%'
group by gender;

--  query 5
select PreferredWorkingEnvironment, count(PreferredWorkingEnvironment) as count
from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
where gender like 'Female%'
group by PreferredWorkingEnvironment
order by count desc
limit 1;
--  the most preffered working environment for female is fully remote with option to travel when needed.

 -- query 6
 select 
 ClosestAspirationalCareer, count(distinct ClosestAspirationalCareer) as count_of_female
 from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
inner join mission_aspirations as ma
on pa.ResponseID=ma.ResponseID
where NoSocialImpactLikelihood between 1 and 5
and gender like 'Female%'
group by ClosestAspirationalCareer;

 select 
 count(gender) as female_count
 from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
inner join mission_aspirations as ma
on pa.ResponseID=ma.ResponseID
where NoSocialImpactLikelihood between 1 and 5
and gender like 'Female%';

-- query 7
select count(gender) as male_count
from personalized_info as pa
inner join learning_aspirations as la
on pa.ResponseID=la.ResponseID
where gender like 'Male%' and
HigherEducationAbroad like 'Yes%' and
CareerInfluenceFactor like 'My Parents%';
-- there are total of 130 male

-- query 8
select gender,
concat(round(count(gender)/(select count(*) from personalized_info)*100,0),'%') as percent
from learning_aspirations as la
inner join personalized_info as pa
on la.responseid=pa.responseid
inner join mission_aspirations as ma
on pa.ResponseID=ma.ResponseID
where NoSocialImpactLikelihood between 8 and 10 and
HigherEducationAbroad like 'Yes%'
group by gender;
-- there are total of 3% male and 1% female.

--  query 9
select PreferredWorkSetup,
count(case when gender like 'Female%' then 1 else 0 end) as Female_count,
count(case when gender like 'Male%' then 1 else 0 end) as male_count,
count(gender) as overall_count,
concat(round(count(*)/(select count(*) from personalized_info)*100,0),'%') as overall_percent
from manager_aspirations as ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where PreferredWorkSetup like '%team'
group by PreferredWorkSetup;



-- query 10
select  WorkLikelihood3Years,
sum(case when gender like 'Male%' then 1 else 0 end) as male,
sum(case when gender like 'Female%' then 1 else 0 end) as female,
count(WorkLikelihood3Years) as total_count
from manager_aspirations as ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
group by WorkLikelihood3Years;

--  query 11
select gender, round(avg(cast(SUBSTRING_INDEX(ExpectedSalary3Years, 'k', 1) as decimal)),2)  AS Avg_Starting_Salary
from mission_aspirations ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
group by Gender;

--  query 12
select gender, round(avg(cast(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) as decimal)),2)  AS Avg_Starting_Salary
from mission_aspirations ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
group by Gender;

--  query 13
SELECT pa.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info as pa
INNER JOIN mission_aspirations as ma
ON pa.ResponseID = ma.ResponseID
GROUP BY pa.Gender;

--  query 14
SELECT pa.Gender,
       AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary5Years,'to',-1),'k',1) AS SIGNED)) AS Avg_Higherbar_Salary
FROM personalized_info as pa
INNER JOIN mission_aspirations as ma
ON pa.ResponseID = ma.ResponseID
GROUP BY pa.Gender;

--  query 15
select CurrentCountry, gender,
round(avg(cast(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) as decimal)),2) as avg_salary
from mission_aspirations ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where CurrentCountry like 'India%'
group by Gender, CurrentCountry
order by gender;

--  query 16
select CurrentCountry, gender,
round(avg(cast(SUBSTRING_INDEX(ExpectedSalary5Years, 'k', 1) as decimal)),2) as avg_salary
from mission_aspirations ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where CurrentCountry like 'India%'
group by Gender, CurrentCountry
order by  gender;

-- query 17
select currentcountry, gender,
 round(AVG(CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(ExpectedSalary3Years,'to',-1),'k',1) AS decimal)),2) AS Avg_Higherbar_Salary
from personalized_info as pa
inner join mission_aspirations as ma
on pa.ResponseID=ma.ResponseID
where CurrentCountry like 'India%'
group by 1,2 
order by 2;

-- query 18
select currentcountry, gender,
round(avg(cast(substring_index(substring_index(ExpectedSalary5Years,'to',-1),'k',1) as decimal)),2) as avg_high_salary
from personalized_info as pa
inner join mission_aspirations as ma
on pa.ResponseID=ma.ResponseID
where CurrentCountry like 'India%'
group by 1,2 
order by 2;

-- query 19
--  people who will work for the companies whose missions are misaligned
select 
sum(case when gender like 'Male%' then 1 else 0 end) as male_count,
sum(case when gender like 'Female%' then 1 else 0 end) as female_count,
count(*) as total_count
from mission_aspirations as ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where CurrentCountry like 'India%' and
MissionUndefinedLikelihood like 'Yes%' and
MisalignedMissionLikelihood like 'will work for%';

--  people who will NOT work for the companies whose missions are misaligned
select 
sum(case when gender like 'Male%' then 1 else 0 end) as male_count,
sum(case when gender like 'Female%' then 1 else 0 end) as female_count,
count(*) as total_count
from mission_aspirations as ma
inner join personalized_info as pa
on ma.ResponseID=pa.ResponseID
where CurrentCountry like 'India%' and
MissionUndefinedLikelihood like 'Yes%' and
MisalignedMissionLikelihood like 'will NOT work for%';



--  THANK YOU
