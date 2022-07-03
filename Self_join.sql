# data base desc https://sqlzoo.net/wiki/Edinburgh_Buses.
# or 
# stops(id, name)
# route(num, company, pos, stop)
# 1. How many stops are in the database.
select count(*) from stops

# 2. Find the id value for the stop 'Craiglockhart'
select id from stops where name = 'Craiglockhart'

# 3. Give the id and the name for the stops on the '4' 'LRT' service.
select id, name from stops
join route on (stops.id = route.stop)
where route.company like 'LRT'
  and route.num like '4'

# 4. Routes and stops
# The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) = 2

# 5 Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 and b.stop=149

# 6. The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'
select 
  companya.company, 
  companya.num, 
  stopsa.name, 
  stopsb.name 
from 
  route companya 
  join route companyb on (
    companya.company = companyb.company 
    and companya.num = companyb.num
  ) 
  join stops stopsa on (companya.stop = stopsa.id) 
  join stops stopsb on (companyb.stop = stopsb.id) 
where 
  stopsa.name = 'Craiglockhart' 
  and stopsb.name = 'London Road'

# 7. Using a self join
# Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

select 
  routea.company, 
  routea.num 
from 
  route routea 
  join route routeb on (
    routea.company = routeb.company 
    and routea.num = routeb.num
  ) 
where 
  (
    routea.stop = 115 
    and routeb.stop = 137
  ) 
group by 
  routea.company, 
  routea.num

# 8. Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

select 
  routea.company, 
  routea.num 
from 
  route routea 
  join route routeb on (
    routea.company = routeb.company 
    and routea.num = routeb.num
  ) 
  join stops stopa on (stopa.id = routea.stop) 
  join stops stopb on (stopb.id = routeb.stop) 
where 
  stopa.name = 'Craiglockhart' 
  and stopb.name = 'Tollcross'

# 9. Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.

select 
 distinct stopb.name, 
 routea.company, 
 routea.num
from route routea
join route routeb on (
    routea.num = routeb.num
    and routea.company = routeb.company
  )
join stops stopa on (routea.stop = stopa.id)
join stops stopb on (routeb.stop = stopb.id)
where stopa.name = 'Craiglockhart' and routea.company = 'LRT'