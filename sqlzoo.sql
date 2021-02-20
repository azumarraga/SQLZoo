-- Using Null

-- 1.
/* List the teachers who have NULL for their department.*/
SELECT name from teacher where dept IS NULL

-- 2.
/*Note the INNER JOIN misses the teachers with no department and the departments with no teacher.*/
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
		   
-- 3.
/* Use a different JOIN so that all teachers are listed.*/
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept
ON (teacher.dept=dept.id)

-- 4.
/* Use a different JOIN so that all departments are listed.*/
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept
ON (teacher.dept=dept.id)


-- 5.
/*Use COALESCE to print the mobile number. Use the number '07986 444 2266' if there is no number given.
 Show teacher name and mobile number or '07986 444 2266'*/
 SELECT name, COALESCE(mobile, '07986 444 2266') FROM teacher
 
-- 6.
/* Use the COALESCE function and a LEFT JOIN to print the teacher name and department name. 
Use the string 'None' where there is no department.*/
SELECT a.name, COALESCE(b.name, 'None') FROM teacher a
LEFT JOIN dept b ON 
a.dept = b.id

-- 7.
/* Use COUNT to show the number of teachers and the number of mobile phones.*/
SELECT COUNT(name), COUNT(mobile) from teacher




-- Self JOIN 

-- 1. 
/* How many stops are in the database.*/
SELECT count(*) FROM stops

-- 2. 
/* Find the id value for the stop 'Craiglockhart'*/
SELECT id from stops WHERE name='Craiglockhart'

-- 3.
/* Give the id and the name for the stops on the '4' 'LRT' service.*/
SELECT st.id, st.name 
FROM stops st LEFT JOIN route rt
ON st.id = rt.stop
WHERE rt.num = '4' AND rt.company = 'LRT'

-- 4. 
/* The query shown gives the number of routes that visit either London Road (149)
 or Craiglockhart (53). Run the query and notice the two services that link these 
 stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.*/
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) >1

-- 5. 
/* Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart,
  without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.*/
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
JOIN stops st ON st.id = a.stop
JOIN stops st2 ON st2.id = b.stop
WHERE st.name= 'Craiglockhart' AND  st2.name = 'London Road'

-- 6.
/* The query shown is similar to the previous one, however by joining two copies of the stops table
 we can refer to stops by name rather than by number. Change the query so that the services between
 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' 
 against 'Tollcross'.*/
 
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road'

--7.
/* Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith').*/
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Haymarket' AND stopb.name='Leith'

--8.
/* Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'.*/
SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company =b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross'

