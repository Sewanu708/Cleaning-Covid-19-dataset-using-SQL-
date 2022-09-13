create database [Covid-19]
use [Covid-19]
--Part A (Data Cleaning)
select * from nigeria

--Dropping column Source,ISO_3,ID_PAYS(country_id)

alter table nigeria
drop column Source,ISO_3,ID_PAYS

--Renaming the column header
--PAYS =Country
sp_rename 'nigeria.PAYS','Country','Column' 
--Region = States
sp_rename 'nigeria.REGION','States','Column' 
--ID_REGION= State_ID,CONTAMINES=Confirmed cases,CONTAMINES_FEMME=Infected Males,CONTAMINES_HOMME=
sp_rename 'nigeria.ID_REGION','State_ID','Column' 
--CONTAMINES=Confirmed cases
sp_rename 'nigeria.CONTAMINES','Confirmed_Cases','Column' 
--DECES=Deaths
sp_rename 'nigeria.DECES','Deaths','Column'
--GUERIS=Recovery
sp_rename 'nigeria.GUERIS','Recovery','Column'
--CONTAMINES_FEMME=Infected Females
sp_rename 'nigeria.CONTAMINES_FEMME','Infected Females','Column'
--CONTAMINES_HOMME= Infected Males
sp_rename 'nigeria.CONTAMINES_HOMME','Infected Males','Column'
--CONTAMINES_GENRE_NON_SPECIFIE=Infected individuals whose Gender is unknown
sp_rename 'nigeria.CONTAMINES_GENRE_NON_SPECIFIE','Infected individuals whose Gender is unknown'

--Removing the timestamp from dates
--update nigeria 
--set [DATE] = cast([DATE] AS date) from nigeria
--the above method does not seem to work

alter table nigeria
add  [Converted_Date] date
update nigeria 
set Converted_Date=cast([DATE] AS date)
alter table nigeria
drop column [date]

select * from nigeria

--changing country from Nigéria to Nigeria 

update nigeria
set Country= replace(country,'Nigéria','Nigeria') 

select distinct states from nigeria order by 1
---Changing state Non spécifié to unknown
update nigeria
set States=replace(States,'Non spécifié','Unknown') where states='Non spécifié'

---checking for nulls
select * from nigeria 
where country is null
select * from nigeria 
where States is null
select * from nigeria 
where State_ID is null
select * from nigeria
where Confirmed_Cases is null
select * from nigeria 
where Deaths is null
select * from nigeria 
where Recovery is null
select * from nigeria 
where [Infected Females] is null
select * from nigeria 
where [Infected Males] is null
select * from nigeria 
where [Infected individuals whose Gender is unknown] is null

alter table nigeria
drop column cc 
update nigeria
set Confirmed_Cases=isnull(Confirmed_Cases,0) from nigeria  where Confirmed_Cases is null
update nigeria
set Deaths=isnull(Deaths,0) from nigeria  where Deaths is null
update nigeria
set Recovery=isnull(Recovery,0) from nigeria  where Recovery is null
update nigeria
set [Infected males]=isnull([Infected Males],0) from nigeria  where [Infected Males] is null
update nigeria
set [Infected females]=isnull([Infected females],0) from nigeria  where [Infected females] is null
update nigeria
set [Infected individuals whose Gender is unknown]=isnull([Infected individuals whose Gender is unknown],0) from nigeria  where [Infected individuals whose Gender is unknown] is null


