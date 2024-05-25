# SQL Murder Mystery
 
# Introduction
SQL Murder Mystery is a fun way to learn and increase my comfortability with using SQL 

A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​. Start by retrieving the corresponding crime scene report from the police department’s database.

More on the data:  

**Website link** - http://mystery.knightlab.com/

**Github Repository** - https://github.com/NUKnightLab/sql-mysteries


# Tools I Used
- **SQL**
- **Sqlite**
- **DBeaver**

# Finding the criminal
 [Murder Mystery](/Murder%20Mystery.sql) to see the whole SQL script.

 ### 1. Crime Scene Reports
 Checking the crime scene reports for murders on January 15, 2018 in SQL City
 ```sql
SELECT *
FROM crime_scene_report csr 
WHERE date = "20180115" and city = "SQL City" and type = "murder"
 ```
 We get a description that says:
 ```
 Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
 ```

 ### 2. Looking at witness reports/interviews
 
 - ***First witness***:
```sql
SELECT *
FROM person p 
WHERE p.address_street_name  = "Northwestern Dr"
ORDER BY address_number DESC 

SELECT transcript 
FROM interview i 
WHERE person_id = "14887"
```

- ***Second Witness***:
```sql
SELECT *
from person p 
WHERE p.name LIKE "Annabel%" and p.address_street_name ="Franklin Ave"

SELECT transcript
FROM interview i 
WHERE person_id ="16371"
```

#### After reading both interview, we now know that the killer:
1. Has a "Get Fit Now Gym" bag that started with "48Z" membership bag. Only gold members have this bag.
2. Has a car with a plate number including "H42W".
3. Was at the gym at January 9th.

### 3. Honing on the murderer
Checking for members with gold membership and id that start with "48Z"
```sql
SELECT *
FROM get_fit_now_member gfnm 
WHERE membership_status = "gold" and id LIKE "48Z%" 
```
Here we can check for more confirmation, like plate numbers and check in account. However, after checking the interviews of the two people that matches the description. 
```sql
SELECT *
FROM interview i 
WHERE person_id in ("28819","67318")
```
***Jeremy Bowers*** admits to committing the murder after being hired
```
I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.
```

### 4. Figuring out who hired Jeremy Bowers
Found 2 people who attended the SQL Symphony Concert 3 times
```sql
SELECT person_id, COUNT(person_id) as amt_attended
FROM facebook_event_checkin fec 
WHERE event_name LIKE "%SQL symphony concert%" and CAST(date as TEXT) LIKE "201712%"
GROUP BY person_id 
ORDER BY amt_attended DESC
```
After searching up the cars that the 2 people have. We figure out that the person who hired Jeremy Bowers is ***Miranda Priestly***
```sql
SELECT *
FROM person p 
WHERE p.id in (99716,24556)

SELECT *
FROM drivers_license dl 
WHERE dl.id in (101191,202298)
```

# Suspects
- Murderer: Jeremy Bowers
- Hirer: Miranda Priestly
