

/************** Evaluación Modulo 2: Extraer Información de la Web y Bases de Datos**************/

             /************** Alumna: Brigitte J. Manrique Báez **************/



-- Seleccionamos la base de datos donde se van a hacer las consultas

USE sakila;

-- Ejercicios --

/* 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
	
SELECT DISTINCT -- Uso DISTINCT para obtener valores únicos y evitar así que los nombres de las peliculas aparezcan duplicados. 
title AS Título
FROM film;


/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/

-- Campos que necesitamos: title, rating
-- Tablas: film
-- Condición/filtro: = 'PG-13'

SELECT
title AS Título,
rating AS Clasificación
FROM film
WHERE rating = 'PG-13';  -- Uso WHERE para establecer la condición.

				/* Comprobación consulta*/
				SELECT *
				FROM film
				WHERE title = 'Airplane sierra';
				-------
				SELECT
				title AS Título,
				rating AS Clasificación
				FROM film
				WHERE rating <> 'PG-13';


/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/

-- Campos que necesitamos: títle, description
-- Tablas: film
-- Condición/filtro: Palabra 'amazing'

SELECT 
title AS Título,
description AS Descripción
FROM film
WHERE description LIKE '%amazing%';  -- Uso la cláusula LIKE para buscar el valor, agregando el caracter especial % al inicio y final de la palabra. Esto ayudará a localizar la palabra completa dentro de la descripción.

				/* Comprobación consulta*/
				SELECT 
				title AS Título,
				description AS Descripción
				FROM film
				WHERE description NOT LIKE '%amazing%';


/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/

-- Campos que necesitamos: title, length
-- Tablas: film
-- Condición/filtro: peliculas con una duración > 120 minutos

SELECT
title AS Título
FROM film
WHERE length > 120;

				/* Comprobación consulta*/
				SELECT *
				FROM film
				WHERE length > 120;  -- En la comprobación verifico que muestra todos los campos de la tabla y confirmo las peliculas con coinciden con una duración inferior a 120 


/* 5. Recupera los nombres de todos los actores.*/

-- Campos que necesitamos: actor_id, first_name
-- Detectar las tablas que necesitamos: actor
-- Condición/filtro: Nombres de todos los actores

SELECT
first_name AS Nombre
FROM actor;
				/* Comprobación consulta*/
                SELECT
                COUNT(actor_id) AS Total_Actores  -- Cuento el ID de los actores para comprobar que el resultado es el mismo. 
                FROM actor;


/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/

-- Campos que necesitamos: first_name, last_name
-- Tablas: actor
-- Condición/filtro: Buscar y seleccionar solo aquellos que tienen como apellido = 'Gibson'

SELECT
first_name AS Nombre, 
last_name AS Apellido
FROM actor
WHERE last_name = 'Gibson';

			/*Comprobación consulta*/
			SELECT *
			FROM actor
			WHERE last_name <> 'Gibson';  -- Para verificar uso el operador: <>. Este operador devuelve todos los actores que no se apellidan 'Gibson. 


/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/

-- Campos que necesitamos: first_name, actor_id
-- Tablas que necesitamos: actor
-- Condición/filtro: actor_id entre 10 y 20

SELECT 
first_name AS Nombre
FROM actor
WHERE actor_id BETWEEN 10 AND 20;

			/*Comprobación consulta*/
			SELECT 
            actor_id,
			first_name
			FROM actor
			WHERE actor_id BETWEEN 10 AND 20; -- Con el campo actor_id compruebo que los resultados de la consulta se cumple. 


/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/

-- Campos que necesitamos: title, rating
-- Detectar las tablas que necesitamos: film
-- Condición/filtro: Que el rating de las películas no sean ni 'R', ni 'PG-13'

SELECT
title AS Título 
FROM film
WHERE rating NOT IN ('R', 'PG-13'); -- Uso el operador de filtro NOT IN para que los valores (titulos de las peliculas) asociados a R y PG-13 no estén presentes en el resultado de la consulta.
		
			/* Comprobación consulta*/
			SELECT
			title AS Título,
			rating AS Clasificación  -- Agrego el campo rating para comprobar los resultados. 
			FROM film
			WHERE rating NOT IN ('R', 'PG-13');  


/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/

-- Campos que necesitamos: rating, film_id
-- Tablas: film
-- Condición/filtro: Cantidad total de películas en cada clasificación. Uso función agregada para hacer el recuento.

SELECT
rating AS Clasificación,
COUNT(film_id) AS Recuento_peliculas -- Uso función agregada COUNT para contar las peliculas de la tabla FILM
FROM film
GROUP BY rating HAVING Recuento_peliculas; -- Agrupo la consulta por Clasificación 

			/* Comprobación consulta*/
			SELECT
			rating AS Clasificación,
			film_id AS Película
			FROM film
			WHERE rating = 'PG'; -- Uso la clausula WHERE para comprobar que, de acuerdo a la clasificacion seleccionada, ésta coincide con el resultado de la consulta.


/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.*/ 

-- Campos que necesitamos: customer_id, first_name, last_name, film_id, rental_id,
-- Tablas: rental, customers.
-- Condición/filtro: Cantidad total de películas alquiladas por cada cliente. Uso función agregada en la tabla rental. 


SELECT
customer.customer_id AS Cliente_ID,
first_name AS Nombre,
last_name AS Apellido,
COUNT(rental_id) AS Total_peliculas_alquiladas  -- Uso la función agregada COUNT para contar los alquileres de peliculas que se han hecho.
FROM customer
LEFT JOIN rental   
ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id HAVING Total_peliculas_alquiladas; -- Agrupo los resultados por cliente  y el total de peliculas alquiladas por cada uno. 

-- Uso LETF JOIN para unir los datos comunes entre ambas tablas y que muestre además, los registros de clientes de la tabla clientes y verifico si hay clientes que no alquilaron peliculas.

				/* Comprobación consulta*/
				SELECT
				customer_id AS Cliente_ID,
				COUNT(rental_id) AS Total_peliculas_alquiladas
				FROM rental
				WHERE customer_id = 1; -- Elijo uno de los clientes que han alquilado peliculas y compruebo el total alquiladas.


/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.*/ 

-- Campos que necesitamos: nombre de la categoria, películas alquiladas
-- Tablas: inventory, category, film_category
-- Condición/filtro: Cantidad total de peliculas alquiladas por categoria. Para el recuento uso funciones agregadas en la tabla rental. 

SELECT
name AS Categoria,
COUNT(rental.rental_id) AS Total_peliculas_alquiladas   -- Uso la función agregada COUNT para contar los alquileres de peliculas que se han hecho
FROM category
INNER JOIN film_category    
ON category.category_id = film_category.category_id  
INNER JOIN inventory
ON film_category.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
GROUP BY name HAVING Total_peliculas_alquiladas;  -- Agrupo los datos por el nombre de la categoría, junto con el total del conteo de peliculas alquiladas por categoría. 

-- Uso INNER JOIN para unir los datos de todas las tablas que se van a unir. Solo necesito conocer las peliculas alquiladas relacionadas por categoría.  
      

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.*/ 

-- Campos que necesitamos: length, rating
-- Detectar las tablas que necesitamos: film
-- Condición/filtro: mostrar el promedio de duración de las peliculas.

SELECT
rating AS Clasificación,
AVG(length) AS Promedio_duracion
FROM film
GROUP BY rating HAVING Promedio_duracion; -- Agrupo por Clasificación, junto con el promedio de duración de las peliculas.

				/* Comprobación consulta*/
                SELECT
                rating AS Clasificación,
                SUM(length)/194 AS Duración  -- Sumo el total de duración de cada una de las películas que hay en la categoría, y luego lo divido por el número de películas de dicha categoría (119)
				FROM film
                WHERE rating = 'PG';-- Selecciono, con la cláusula WHERE, una de la categorías de la tabla para hacer la comprobación.


/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/

-- Campos que necesitamos: first_name, last_name, title film
-- Tablas: film, film_actor, actor
-- Condición/filtro: actores que hayan participado en Indian Love

SELECT
first_name AS Nombre,
last_name AS Apellidos
FROM actor
INNER JOIN film_actor      
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
WHERE title IN ('Indian Love'); 

-- Uso INNER JOIN en todas las uniones de tablas porque queremos obtener los actores que participaron en la película 'Indian Love', y no todos los actores, hayan actuado o no en esa película.
-- Uso en la consulta film_id para conocer el código de la película Indian Love y hacer la comprobación. Luego elimino este campo.

				/*Comprobación consulta*/

				SELECT
				actor_id AS Cliente_ID,
				film_id AS Pelicula
				FROM film_actor
				WHERE film_id = 458;


/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/ 

-- Campos que necesitamos: title, description
-- Tablas: film
-- Condición/filtro: peliculas que contengan en su titulo 'dog' o 'cat'

SELECT
title AS Título
FROM film
WHERE description REGEXP 'CAT | DOG';  -- El caracter:| indica que puede ser una opción u otra. 
--------------------
SELECT
title AS Título
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%'; -- Usando el operador especial LIKE junto con el porcentaje, obtenemos los mismos resultados que usando REGEXP y el carácter: |

				/* Comprobación consulta*/
                SELECT
				title AS Título,
                description AS Descripción
				FROM film
				WHERE description REGEXP 'CAT | DOG';


/* 15. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/

-- Campos que necesitamos: title, release year
-- Tablas: film
-- Condición/filtro: fecha de lanzamiento entre 2005 y 2010

SELECT
title AS Título,
release_year AS Año_Lanzamiento
FROM film
WHERE release_year BETWEEN 2005 AND 2010;  -- Uso operador de filtrado BETWEEN para delimitar la búsqueda entre dos valores y/o fechas.

				/* Comprobación consulta */ 
				SELECT
				*
				FROM film
				WHERE title = 'academy dinosaur';   -- Usando uno de los resultados de la consulta, confirmo que la película está dentro de la condición y/o filtro.


/* 16. Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

-- Campos que necesitamos: categoria, titulo de peliculas
-- Tablas que necesitamos: categoria, film_category
-- Condición/filtro: peliculas que estén dentro de la categoría 'Family'

SELECT 
title AS Título,
category.name AS Categoría
FROM film 
LEFT JOIN film_category                      
ON film.film_id = film_category.film_id
LEFT JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

-- Uso LETF JOIN en esta consulta para unir los datos comunes entre ambas tablas y que muestre además, los registros de todas las peliculas de la tabla film, y verifico que si hay alguna que no esté dentro de alguna categoría.
-- Uso en la consulta category_id para conocer el código de la categoria Family y hacer la comprobación. Luego elimino este campo. 


				/* Comprobación consulta*/
				SELECT
				category_id AS Categoría,
				film_id AS Pelicula
				FROM film_category
				WHERE category_id = 8;


/* 17. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/

-- Campos que necesitamos: title, rating, duracion
-- Tablas: film
-- Condición/filtro: Que las peliculas estén dentro de la clasificación R y duren más de 2 horas.


SELECT
title AS Título
FROM film
WHERE length > 120 AND rating = 'R';


				/* Comprobación consulta*/
				SELECT 
				title AS Título,
				rating,
				length
				FROM film
				WHERE length > 120 AND rating = 'R';  -- Uso los campos rating y length para verificar que se cumple la condición


/*BONUS*/

/*18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

-- Campos que necesitamos: first_name, last_name, film_id
-- Tablas que necesitamos: actor, film_actor
-- Condición/filtro: actores que aparecen en más de 10 peliculas

SELECT
first_name AS Nombre,
last_name AS Apellido,
COUNT(DISTINCT film_actor.film_id) AS Número_Peliculas  -- Uso la función agregada COUNT en la tabla de film_actor para conocer el número de películas por actor.
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY actor.actor_id -- -- Agrupamos por actor
HAVING Número_Peliculas > 10; -- Filtro por conteo superior a 10 películas. 

-- Uso INNER JOIN porque queremos conocer los actores que tienen más de 10 peliculas, y no todos los actores independientemente de si cumplen esa condición o no. Para ello vinculamos actores con peliculas en las que han participado.
-- Uso en la consulta el campo actor.actor_id para conocer el código de identificación del actor y así poder hacer la comprobación. Luego elimino este campo. 


				/* Comprobación consulta*/

				SELECT
				actor_id AS Actor,
				count(film_id) AS Peliculas_Actor
				FROM film_actor
				WHERE actor_id = 38;


/*19. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor.*/ /* ¡¡¡¡¡Preguntar enunciado!!!!! */

-- Campos que necesitamos: actor_id, film_id
-- Tablas que necesitamos: film_actor
-- Condición/filtro: Comprobar si hay algún actor o actriz que no aparezca en ninguna pelicula. 

SELECT
actor_id AS Actor,
film_id AS Pelicula
FROM film_actor
WHERE actor_id NOT IN ( 
	SELECT actor_id FROM film_actor)  
ORDER BY actor;

-- Uso en la consulta los campos actor_id y film_id para hacer la búsqueda. En el resultado podemos ver que no aparece ningún actor o actriz que no haya participado en ninguna película.   

				/* Comprobación consulta*/ 
				SELECT 
				actor_id AS Actor,
				film_id AS Película
				FROM film_actor
				WHERE actor_id IS NULL OR NOT NULL AND film_id IS NOT NULL OR NULL;   

				-- Esta comprobación me genera dudas pero aún así pienso que es una forma de verificar que el resultado de la consulta es correcto. Esta comprobación no se me ocurre hacerla de otra manera. 


/*20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración.*/

-- Campos que necesitamos: .category.name, category_id, length
-- Tablas: category, film_category, film
-- Condición/filtro: Encontrar las categorias que tengan un promedio de duración superior a 120 minutos. Uso función agregada AVG en el campo LENGTH para sacar el promedio de las peliculas.

SELECT
category.category_id,
name as Categoria,
AVG(film.length) AS Duracion_promedio  -- 
FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER JOIN film 
ON film_category.film_id = film.film_id
GROUP BY name   -- Agrupo por nombre de categoría
HAVING Duracion_promedio > 120; -- Filtro por promedio superior a 120 minutos.

-- Uso INNER JOIN porque queremos encontrar solo las categorias de peliculas que tengan un promedio superior a 120 minutos. No necesitamos todos los registros de categorías de la tabla. 
-- Uso el campo category_id para conocer el código de identifcación de la categoría y luego poder hacer la comprobación. Luego lo elimino de la consulta. 
             
           
/*21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado.*/

-- Campos que necesitamos: first_name, film_id, actor_id
-- Tablas: actor, film actor
-- Condición/filtro: actores que hayan actuado en >=5 peliculas. Uso funciones agregadas para hacer el conteo.

SELECT
first_name,
COUNT(film_actor.film_id) AS Cantidad_peliculas  -- Uso función agregada COUNT para contar las peliculas por actor.
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
GROUP BY first_name  -- Agrupo por nombre del actor o actriz
HAVING Cantidad_peliculas >=5; -- Filtro para que muestre el resultado de al menos 5 películas


-- Uso el campo actor_id para conocer el código de identifcación del actor y luego poder hacer la comprobación. Luego lo elimino de la consulta.
-- Uso INNER JOIN porque solo necesitamos los actores que han participado en alguna película de la tabla de film_actor. Luego ya agregamos la condición donde muestre el resultado de al menos 5 películas. 

				/*Comprobación consulta*/
				SELECT
				actor_id,
				COUNT(film_id) AS min_Cantidad_peliculas
				FROM film_actor
				WHERE actor_id = 19
				GROUP BY actor_id; 


/*22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.*/

-- Campos que necesitamos: title, rental_id, rental_date, return_date, inventory_id
-- Tablas: film, rental
-- Condición/filtro: peliculas alquiladas por mas de 5 dias

SELECT DISTINCT
title AS Título,
DATEDIFF (return_date, rental_date) AS Días_alquiladas  -- Uso DATEDIFF para que calcule la diferencia entre días.
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
WHERE rental_id IN (
	SELECT
	rental_id
	FROM rental
	WHERE DATEDIFF (return_date, rental_date) > 5 )  -- Uso operador de comparación > para que se muestren los resultados de las peliculas alquiladas por más de 5 dias
;

-- Hago primero una consulta que muestre la diferencia entre fechas y que sea superior a 5 dias. 
-- Uso INNER JOIN porque necesito vincular todas las películas que fueron alquiladas. No necesito conocer todos los registros de la tabla film, solo las que aparecen relacionadas con la tabla rental. 
-- Luego la compruebo usando el operador de comparación '<'. Elimino el operador tras la comprobación. 



/*23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores.*/

-- Campos que necesitamos: first_name, last_name, actor_id, category.name
-- Tablas: actor, film_actor, film_category
-- Condición/filtro: Encontrar actores que no hayan actuado en peliculas con categoría 'Horror'

SELECT
first_name AS Nombre,
last_name AS Apellido
FROM actor
WHERE actor_id NOT IN (      -- Para excluir a los actores que han participado en peliculas de 'Horror' uso el operador de filtrado especial NOT IN en la consulta principal. 
	SELECT
	actor.actor_id
    FROM actor
    INNER JOIN film_actor
    ON actor.actor_id = film_actor.actor_id
    INNER JOIN film_category
    ON film_actor.film_id = film_category.film_id
    INNER JOIN category
    ON film_category.category_id = category.category_id
    WHERE category.name = 'Horror');

-- Uso INNER JOIN para que la relación entre las tablas muestre los datos comunes entre ellas y no más registros de actores, por ejemplo, que no cumplan la condición.

           
/*24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.*/

-- Campos que necesitamos: title, lenght, category.name
-- Tablas: film, category
-- Condición/filtro: peliculas con categoria comedia y con más de 180 minutos de duración.

SELECT
category.name AS Categoria,
title AS Titulo,
length
FROM film
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE category.name = 'Comedy' AND length > 180; 

-- Uso INNER JOIN porque solo necesitamos los títulos de las peliculas que estén relacionadas con la categoría comedia. No es necesario usar todas las peliculas tengan asociada o no una categoría.
-- Uso el campo film_id para conocer el código de identificación de la pelicula y luego poder hacer la comprobación usando la tabla film. Luego lo elimino de la consulta.


				/* Comprobación consulta*/
				SELECT 
				title AS Título,				
				length
				FROM film
				WHERE film_id = 182;


/*25. Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos.*/

-- Campos que necesitamos: first_name, last_name, film_id, actor_id
-- Tablas: actor, film_actor
-- Condición/filtro: actores que hayan coincidido en al menos una pelicula.

/* PASOS*/ 
-- Visualizo los campos que quiero en la tabla de resultado

-- nombre_actor1 | apellido_actor_1 | nombre_actor2 | apellido_actor2 | Número de peliculas en las que coinciden

-- Para poder ver los datos distribuidos en estos campos, necesito combinar o unir cada tabla (actor y film_actor consigo mismas). Conceptos buscados en internet y ChatGPT
-- actor original | actor AS actor2  |  film_actor original | film_actor AS film_actor2


SELECT
actor.first_name AS Nombre_actor1,
actor.last_name AS Apellido_actor1,
actor2.first_name AS Nombre_actor2,
actor2.last_name AS Apellido_actor2,
COUNT(film_actor.film_id) AS Número_Películas   -- Uso función agregada COUNT para contar el número de peliculas
FROM actor 
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id   -- Campo de relación entre las dos tablas es actor_id
INNER JOIN film_actor AS film_actor2      -- Unión de tabla consigo misma
ON film_actor.film_id = film_actor2.film_id  -- Campo de relación entre las dos tablas es film_id
INNER JOIN actor AS actor2                -- Unión de tabla consigo misma
ON film_actor2.actor_id = actor2.actor_id    -- Campo de relación entre las dos tablas es actor_id
-- Uno las tablas con INNER JOIN para conseguir solo los datos comunes entre tablas.
-- Aplico la condición que necesito para se muestren las peliculas en las que han trabajado juntos.
WHERE actor.actor_id < actor2.actor_id  -- Uso el operador de comparación '<' para indicar que el actor_id de la tabla actor es menor que el actor_id de la tabla actor2. De este modo evitamos duplicidades.
GROUP BY actor.first_name, actor.last_name, actor2.first_name, actor2.last_name  -- Agrupamos por los campos de nombres y apellidos de las dos tablas de actores.
HAVING Número_Películas >= 1;

-- Este ejercicio ha supuesto un reto. Después de muchos intentos sin éxito, finalmente he acudido a ChatGPT y otras fuentes de internet para entender conceptos de unión de tablas consigo mismas. 
-- No he querido plasmarlo aquí hasta no tenerlo completamente desgranado, y comprendidos cada uno de los pasos para su resolución. 




