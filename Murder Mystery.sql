--Search for murder crimes that happened in 20180115 in SQL City
SELECT *
FROM crime_scene_report csr 
WHERE date = "20180115" and city = "SQL City" and type = "murder"

--Search for first witness
SELECT *
FROM person p 
WHERE p.address_street_name  = "Northwestern Dr"
ORDER BY address_number DESC 

--First witness ID is 14887 and name is Morty Schapiro
--We look now at his interview
SELECT transcript 
FROM interview i 
WHERE person_id = "14887"

--Search for second witness
SELECT *
from person p 
WHERE p.name LIKE "Annabel%" and p.address_street_name ="Franklin Ave"

--Second witness ID is 16371
--We look now at her interview
SELECT transcript
FROM interview i 
WHERE person_id ="16371"

/* Killer has :
 * 		"Get Fit Now Gym" bag started with "48Z" membership number. He's a gold member
 * 		Plate Car number: "H42W"
 * 		Was at the gym on Jan 9th
 */

--Check members started with 48Z number and gold member
SELECT *
FROM get_fit_now_member gfnm 
WHERE membership_status = "gold" and id LIKE "48Z%"

--Check if the two members checked in at jan 9th
SELECT *
FROM get_fit_now_check_in gfnci 
WHERE membership_id  IN ("48Z7A","48Z55") and check_in_date ="20180109"

--Check Drivers License with "H42W"
SELECT *
FROM drivers_license dl 
WHERE plate_number LIKE "%H42W%"

--Check Interviews of the two members with "48Z" bag
SELECT *
FROM interview i 
WHERE person_id in ("28819","67318")

--We got an interview from Jeremy Bowers admitting the crime

/*The woman who hired Jermey Bowers has :
 * Lot of money, around 5'5"(65") or 5'7"(67"), red hair, drives a Tesla Model S,
 * Attended SQL Symphony Concert 3 times in December 2017
 */

SELECT person_id, COUNT(person_id) as amt_attended
FROM facebook_event_checkin fec 
WHERE event_name LIKE "%SQL symphony concert%" and CAST(date as TEXT) LIKE "201712%"
GROUP BY person_id 
ORDER BY amt_attended DESC

--The two people who attended 3 SQL Symphony in Dec 2017 is 99716 and 24556
SELECT *
FROM person p 
WHERE p.id in (99716,24556)

SELECT *
FROM drivers_license dl 
WHERE dl.id in (101191,202298)

SELECT *
FROM income
WHERE ssn = 987756388

--It's Miranda Priestly

INSERT INTO solution VALUES (1, "Miranda Priestly");

SELECT value FROM solution;