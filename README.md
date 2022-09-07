# Data Cleaning with SQL
## Introduction
The COVID-19 pandemic in Nigeria is part of the worldwide pandemic of coronavirus disease 2019 caused by severe acute respiratory syndrome coronavirus 2.
This project entails cleaning a covid-19 dataset (which contains some French terms) using sql.
The relational database management software used in this project is SQL Server Management Studio.
## Aims of this project
- Deleting unwanted columns
- Changing the column headers 
- Removing timestamp from the dates
- Replacing the content of some column with their English terms
- Replacing nulls with 0.

## Overview of the dataset
<img width="934" alt="overview" src="https://user-images.githubusercontent.com/99955484/188759483-5cfbfb36-8205-49d4-895c-fd0005038eaf.png">

## Pre-cleaning 
- Created a new database  **Covid-19**
- Imported my table i.e datasets into the newly created database 
- Named the table **nigeria**
<img width="139" alt="ok" src="https://user-images.githubusercontent.com/99955484/188760287-ed4f8bb0-b33b-49ab-bd8d-1627b0f5df5c.png">

## Cleaning Steps
#### 1. Deleting unwanted columns
```
--Dropping column Source,ISO_3,ID_PAYS(country_id)

alter table nigeria
drop column Source,ISO_3,ID_PAYS
```

- The column **Source** is of no use since we're not interested in the source of the data
- Column ISO_3 is also of no use because:
  - it contains code used to identify a country
  - The codes are not unique i.e it's the same throughout the table
- Column ID_PAYS(meaning country id) is also of no relevance since the dataset consist of only one country 

*new table view after deleting unwanted columns*
<img width="755" alt="after dropping columns" src="https://user-images.githubusercontent.com/99955484/188761801-29f740ea-4c9b-4728-be5c-34ceee5ea75c.png">

#### 2.Changing the column headers 
The main reason some of the column headers are being changed  is because they were computed in French.
I used stored procedures to change them although  there are other ways of doing it
```
--Renaming the column header
--PAYS =Country
sp_rename 'nigeria.PAYS','Country','Column' 
--Region = States
sp_rename 'nigeria.REGION','States','Column' 
--ID_REGION= State_ID
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
```

*new table view after changing spme column header*
<img width="774" alt="after changing column header" src="https://user-images.githubusercontent.com/99955484/188763562-b395d87a-a643-413a-a308-9b1971768e89.png">

#### 3. Removing timestamp from date
The date column initailly does not have a timestamp but during the process of importing the table into the **Covid-19** database, SQL Server changed the datatype of the column to datetime.
```
--Removing the timestamp from dates
--update nigeria 
--set [DATE] = cast([DATE] AS date) from nigeria
--***the above method does not seem to work***

alter table nigeria
add  [Converted_Date] date
update nigeria 
set Converted_Date=cast([DATE] AS date)
alter table nigeria
drop column [date]
```
<img width="152" alt="a" src="https://user-images.githubusercontent.com/99955484/188764884-8ca8aeca-4412-4330-a3e1-fc95c7bee5b9.png">

Instead of just updating the column, i deleted it because te **update** didn't seem to work as it was still returning the timestamp alongside the date
