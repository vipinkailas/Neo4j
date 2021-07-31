Advanced Cypher

MATCH (m:Movie)<-[:ACTED_IN]-(actor)
WITH actor,collect(m) AS movies,COUNT(m) AS movieCount
ORDER BY movieCount DESC LIMIT 5
UNWIND movies as movie
RETURN movie,actor

MATCH (a:Person)-[ACTED_IN]->()
WITH collect(a) AS actors
MATCH(d:Person)-[DIRECTED]->()
WITH actors,collect(d) AS directors
UNWIND(actors+directors) AS people
WITH DISTINCT(people)
RETURN people.name as Names ORDER BY Names LIMIT 10

Pattern Comprehension

Post UNION processing using Call{}

CALL{
MATCH(p:Person)
WHERE p.born > 1980
RETURN 'person' as type, p.name as name, p.born as year
ORDER BY year ASC limit 5

UNION

MATCH(m:Movie)
WHERE m.releaseYear > 2008
RETURN 'movie' as type, m.title as name,m.releaseYear as year
ORDER BY year DESC limit 5
}
RETURN * ORDER BY year desc

CALL{
MATCH(p:Person)
RETURN p ORDER BY p.born ASC LIMIT 5

UNION

MATCH(p:Person)
RETURN p ORDER BY p.born DESC LIMIT 5
}
RETURN p.name,p.born ORDER BY p.name

WITH
———


MATCH (p1:Person)-[:ACTED_IN]->(m:Movie)<-[:DIRECTED]-(director:Person)
WHERE p1.name = 'Tome Hanks'
WITH director
MATCH(director)-[:DIRECTED]->(otherMovie:Movie)
RETURN director,otherMovie