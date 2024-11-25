
/* Ejercicios*/

USE sakila;

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
	
SELECT DISTINCT
title 
FROM film;

/* Comprobación consulta*/
SELECT
title
FROM film
WHERE title > 1;


/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/

-- Detectar los campos que necesitamos: nombre de peliculas, clasificación (rating)
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: = 'PG-13'

SELECT
title,
rating
FROM film
WHERE rating = 'PG-13';

/* Comprobación consulta*/
SELECT *
FROM film
WHERE title = 'Airplane sierra';
-------
SELECT
title,
rating
FROM film
WHERE rating <> 'PG-13';


/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/

-- Detectar los campos que necesitamos: título, descripción
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: Palabra 'amazing'

SELECT 
title,
description
FROM film
WHERE description LIKE '%amazing%';  -- La palabra se encuentra dentro de la descripción, no especifica si al principio o al final. 

/* Comprobación consulta*/
SELECT 
title,
description
FROM film
WHERE description NOT LIKE '%amazing%';


/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

-- Detectar los campos que necesitamos: titulo, duracion
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: duración > 120 minutos

SELECT
title,
length
FROM film
WHERE length > 120;

/* Comprobación consulta*/
SELECT *
FROM film
WHERE length < 120;


/* 5. Recupera los nombres de todos los actores.*/

-- Detectar los campos que necesitamos: actor_id, nombres
-- Detectar las tablas que necesitamos: actor
-- ¿Cuál es la condición/filtro?: ----

SELECT
actor_id,
first_name
FROM actor;


/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

-- Detectar los campos que necesitamos: nombre, apellidos
-- Detectar las tablas que necesitamos: actor
-- ¿Cuál es la condición/filtro?: apellido = 'Gibson'

SELECT
first_name, 
last_name
FROM actor
WHERE last_name = 'Gibson';

/*Comprobación consulta*/
SELECT *
FROM actor
WHERE last_name <> 'Gibson';


/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

-- Detectar los campos que necesitamos: nombres, actor_id
-- Detectar las tablas que necesitamos: actor
-- ¿Cuál es la condición/filtro?: actor_id entre 10 y 20

SELECT 
actor_id,
first_name
FROM actor
WHERE actor_id BETWEEN 10 AND 20;


/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/

-- Detectar los campos que necesitamos: título de las películas, clasificación (rating)
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: que el rating de las películas no sean ni 'R', ni 'PG-13'

SELECT
title, 
rating
FROM film
WHERE rating NOT IN ('R', 'PG-13');


/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/

-- Detectar los campos que necesitamos: clasificación (rating), film_id
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: cantidad total de películas en cada clasificación. Uso función agregada para hacer el recuento.

SELECT
rating AS Clasificación,
COUNT(film_id) AS Recuento_peliculas
FROM film
GROUP BY rating HAVING recuento_peliculas;

/* Comprobación consulta*/
SELECT
rating,
film_id
FROM film
WHERE rating = 'PG';

/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/ 

-- Detectar los campos que necesitamos: customer_id, first_name, last_name, film_id, rental_id,
-- Detectar las tablas que necesitamos: rental, customers.
-- ¿Cuál es la condición/filtro?: cantidad total de películas alquiladas por cada cliente. Uso función agregada. 


SELECT
customer.customer_id,
first_name,
last_name,
COUNT(inventory_id) AS total_peliculas_alquiladas
FROM customer
LEFT JOIN rental
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id HAVING total_peliculas_alquiladas;

/* Comprobación consulta*/
SELECT
customer_id,
COUNT(inventory_id)
FROM rental
WHERE customer_id = 1;



/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/ /* ¡¡¡¡¡¡¡¡REVISAR!!!!!!!*/

-- Detectar los campos que necesitamos: nombre de la categoria, películas alquiladas
-- Detectar las tablas que necesitamos: inventory, category, film_category
-- ¿Cuál es la condición/filtro?: cantidad total de peliculas alquiladas por categoria. Para el recuento usamos funciones agregadas. 

SELECT
category.name,
COUNT(inventory_id) 
FROM inventory;




/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/ /* ¡¡¡¡¡¡¡¡REVISAR!!!!!!!*/

-- Detectar los campos que necesitamos: duración, clasificación (rating)
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: mostrar el promedio de duración de las peliculas.

SELECT
AVG(length) AS Promedio_película,
rating
FROM film
GROUP BY rating HAVING Promedio_película; 

/*Comprobación consulta*/



/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

-- Detectar los campos que necesitamos: first_name, last_name, title film
-- Detectar las tablas que necesitamos: film, film_actor, actor
-- ¿Cuál es la condición/filtro?: actores que hayan participado en Indian Love

SELECT
first_name,
last_name
FROM actor
LEFT JOIN film_actor
ON actor.actor_id = film_actor.actor_id
LEFT JOIN film
ON film_actor.film_id = film.film_id
WHERE title IN ('Indian Love'); 

/*Comprobación consulta*/

SELECT
actor_id,
film_id
FROM film_actor
WHERE film_id = 458;


/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/ /*¡¡¡¡¡¡¡¡REVISAR!!!!!!*/

-- Detectar los campos que necesitamos: title, descripción
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: peliculas que contengan en su titulo 'dog' o 'cat'

SELECT
title,
description
FROM film
WHERE description LIKE '%CAT%' '%DOG%';  -- Cat: 70 y Dog: 99 Dependiendo de la posición de las palabras sale un resultado u otro. 



/* 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/

-- Detectar los campos que necesitamos: title, release year
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: fecha de lanzamiento entre 2005 y 2010

SELECT
title,
release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

/* Comprobación consulta */ 
SELECT
*
FROM film
WHERE title = 'academy dinosaur';


/* 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

-- Detectar los campos que necesitamos: categoria, titulo de peliculas
-- Detectar las tablas que necesitamos: categoria, film_category
-- ¿Cuál es la condición/filtro?: peliculas que estén dentro de la categoría 'Family'

SELECT 
title,
category.name
FROM film 
LEFT JOIN film_category
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

/* Comprobación consulta*/
SELECT
category_id
film_id
FROM film_category
WHERE category_id = 8;


/* 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/

-- Detectar los campos que necesitamos: title, rating, duracion
-- Detectar las tablas que necesitamos: film
-- ¿Cuál es la condición/filtro?: que las peliculas estén dentro de la clasificación R y duren más de 2 horas.


SELECT
title,
rating,
length
FROM film
WHERE length > 120 AND rating = 'R';

/* Comprobación consulta*/
SELECT 
*
FROM film
WHERE length < 120 AND rating <> 'R';



/*BONUS*/

/*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:




/*19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:




/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:



/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:



/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:

/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:

/*24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:

/*25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

-- Detectar los campos que necesitamos: 
-- Detectar las tablas que necesitamos:
-- ¿Cuál es la condición/filtro?:














