				/* QUERIES */
use blogs;

select * from posts;
select titulo, fecha_publicacion, estatus from posts;
select titulo as ENCABEZADO, fecha_publicacion, estatus from posts;

select count(*) from posts; -- Contar todo
select count(*) from usuarios;

-- JOINS --
select * from usuarios;

-- LEFT JOIN
select * from usuarios left join posts on usuarios.id = posts.usuario_id; -- Todo de usuarios y posts tengan o no posts- todo de A sin importar lo de B
select * from usuarios left join posts on usuarios.id = posts.usuario_id where posts.usuario_id is null;

-- RIGHT JOIN
select * from usuarios right join posts on usuarios.id = posts.usuario_id; -- Todo de usuarios y posts tengan o no usuarios- todo de B haya o no en A
select * from usuarios right join posts on usuarios.id = posts.usuario_id where posts.usuario_id is null; 

-- INNER JOIN
select * from usuarios inner join posts on usuarios.id = posts.usuario_id; -- Todo de usuarios y posts con interseccion existente

-- FULL JOIN
select * from usuarios left join posts on usuarios.id = posts.usuario_id union select * from usuarios right join posts on usuarios.id = posts.usuario_id; -- TODO DE TODO

-- DIFERENCIA SIMETRICA
select * from usuarios left join posts on usuarios.id = posts.usuario_id where posts.usuario_id is null 
union 
select * from usuarios right join posts on usuarios.id = posts.usuario_id where posts.usuario_id is null; -- Los que no tienen relaciones

					/* WHERE */
use blogs;
select * from posts where id > 50; 

select * from posts where estatus = 'activo'; 
select * from posts where estatus = 'inactivo';
select * from posts where id = 47;

select * from posts where titulo like '%escandalo%'; -- Texto que contenga
select * from posts where id like '6%'; 
select * from posts where titulo like '%roja'; -- Texto que contenga

select * from posts where fecha_publicacion > '2025-01-01'; -- Fechas
select * from posts where fecha_publicacion between '2026-01-01' and '2026-12-31'; -- Fechas en rango
select * from posts where year(fecha_publicacion) between '2020' and '2021'; -- Fechas en rango
select * from posts where month(fecha_publicacion) = '04'; -- Fechas en rango

select * from posts where id between 50 and 60; -- Numeros rangos

-- Valores Nulos
select * from posts where usuario_id is null; -- Directo con IS
select * from posts where usuario_id is not null and estatus = 'activo'; -- Directo con IS: todos que si tienen usuario
select * from posts where usuario_id is not null and estatus = 'activo' and id < 50 and categoria_id = 2;

select * from posts where usuario_id is not null 
and estatus = 'activo' 
and id < 50 
and categoria_id = 2
and year(fecha_publicacion) = '2030';

-- GROUP BY y ORDER BY
select estatus, count(*) as numero_posts from posts group by estatus; -- agrupados por

select year(fecha_publicacion) as años, count(*) as numero_posts 
from posts 
group by años -- agrupados por años
order by años; -- ordenados por año 

select monthname((fecha_publicacion)) as meses, count(*) as numero_posts 
from posts 
group by meses; -- agrupados por meses

select estatus, monthname((fecha_publicacion)) as meses, count(*) as numero_posts 
from posts 
group by estatus, meses -- agrupados por estatus y meses
order by estatus, meses; 

	-- ORDER BY --
    
select * from posts order by fecha_publicacion asc; -- Ordenar por defecto asc
select * from posts order by fecha_publicacion desc; -- Ordenar por defecto desc

select * from posts order by titulo desc; 

select * from posts order by usuario_id asc;
select * from posts order by usuario_id desc;

select * from posts order by fecha_publicacion asc limit 5; -- limitar cantidad de datos

select estatus, monthname(fecha_publicacion) as meses, count(*) as numero_posts 
from posts 
group by estatus, meses
having numero_posts = 1		-- Filtrando los resultados
order by meses;

	-- SUB QUERIES / QUERIES ANIDADAS --

select new_table.date, count(*) as cuenta_posts
from (
	select date(min(fecha_publicacion)) as date, year(fecha_publicacion) as post_year
    from posts
    group by post_year
) as new_table
group by new_table.date
order by new_table.date;

-- Sub querie para obtener todos los datos del post de fecha mas reciente --
select * from posts 
where fecha_publicacion = (
	select max(fecha_publicacion)
    from posts
);		

	-- OTHER QUERIES WITH JOINS --

select * from posts;    	
select * from etiquetas;    
select * from posts_etiquetas;    
 
 -- Conteo de etiquetas por cada post --
select posts.titulo, count(*) as num_etiquetas
from posts
inner join posts_etiquetas on posts.id = posts_etiquetas.post_id 
inner join etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
group by posts.id
order by num_etiquetas desc;

-- Obteniendo datos y concatenandolos --
select posts.titulo, group_concat(nombre_etiqueta)	-- Concatenar datos en grupo separados por ','
from posts
inner join posts_etiquetas on posts.id = posts_etiquetas.post_id 
inner join etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
group by posts.id;

-- Datos de etiquetas que no tengan posts --
select *
from etiquetas
left join posts_etiquetas on etiquetas.id = posts_etiquetas.etiqueta_id
where posts_etiquetas.etiqueta_id is NULL;
 
 -- Obteniendo datos de posts por categorias --
select * from categorias;
select * from posts;
 
 -- Cuantos posts existen por categoria -- 
select categorias.id, nombre_categoria, count(*) as num_posts
from categorias
inner join posts on categorias.id = posts.categoria_id
group by categorias.id
order by num_posts desc
limit 1;

 -- Usuarios que tengan mas posts y de que categoria son--  
 select * from usuarios;
 select * from posts;
 
 select usuario_id, nickname, count(*) as num_posts, group_concat(nombre_categoria) as categorias
 from usuarios
 inner join posts on usuarios.id = posts.usuario_id
 inner join categorias on categorias.id = posts.categoria_id 
 group by usuario_id
 order by num_posts desc;
 
  -- Usuarios que no han escrito ningun post --
  select *
  from usuarios
  left join posts on posts.usuario_id = usuarios.id
  where posts.usuario_id is NULL
  
  
 
 







    


















