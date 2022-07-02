#1. List the films where the yr is 1962 [Show id, title]

select movie.id, movie.title from movie where yr = 1962

# 2. When was Citizen Kane released?
# Give year of 'Citizen Kane'.

select yr from movie where title = 'Citizen Kane'

# 3. Star Trek movies.
# List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

# 4. id for actor Glenn Close
# What id number does the actor 'Glenn Close' have?

select id from actor where name = 'Glenn Close'

# 5. id for Casablanca 
# What is the id of the film 'Casablanca'.

select id from movie where title = 'Casablanca'

# 6. Cast list for Casablanca
# Obtain the cast list for 'Casablanca'.
# what is a cast list?
# The cast list is the names of the actors who were in the movie.
# Use movieid=11768, (or whatever value you got from the previous question).

select name from actor join casting on (actor.id = casting.actorid)
where casting.movieid = 132689

# 7. Alien cast list.
# Obtain the cast list for the film 'Alien'.

SELECT actor.name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
JOIN movie ON (movie.id = casting.movieid)
WHERE movie.title = 'Alien'

# 8. Harrison Ford movies.
# List the films in which 'Harrison Ford' has appeared.

SELECT movie.title
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE actor.name = 'Harrison Ford'

# 9. Harrison Ford as a supporting actor.
# List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role].

SELECT title
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE casting.ord <> 1
  AND actor.name = 'Harrison Ford'

# 10. Lead actors in 1962 movies.
# List the films together with the leading star for all 1962 films.

SELECT movie.title,
       actor.name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE casting.ord = 1
  AND movie.yr = 1962

# 11. Busy years for Rock Hudson.
# Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT movie.yr,
       count(*)
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE actor.name = 'Rock Hudson'
GROUP BY actor.name,
         movie.yr
HAVING COUNT (*) > 2

# 12. Lead actor in Julie Andrews movies.
# List the film title and the leading actor for all of the films 'Julie Andrews' played in.
# Did you get "Little Miss Marker twice"?
# Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
# Title is not a unique field, create a table of IDs in your subquery.

SELECT movie.title,
       actor.name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE movie.id in
    (SELECT movie.id
     FROM movie
     JOIN casting ON (movie.id = casting.movieid)
     JOIN actor ON (actor.id = casting.actorid)
     WHERE actor.name = 'Julie Andrews')
  AND casting.ord = 1

# 13. Actors with 15 leading roles.

# Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT actor.name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
WHERE casting.ord = 1
GROUP BY actor.name
HAVING count(*) >= 15
ORDER BY actor.name

# 14. released in the year 1978.
# List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT movie.title,
       count(*)
FROM movie
JOIN casting ON (movie.id = casting.movieid)
WHERE movie.yr = 1978
GROUP BY movie.id
ORDER BY count(*) DESC, movie.title

