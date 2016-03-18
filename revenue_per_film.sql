select f.film_id, f.title, f.rental_rate*count(*)
from rental r, inventory i, film f
where
r.inventory_id = i.inventory_id
and i.film_id=f.film_id
group by f.film_id;

DROP TEMPORARY TABLE IF EXISTS revenue_per_film;
create temporary table revenue_per_film
select f.film_id, f.title, f.rental_rate*count(*) total_revenue
from rental r, inventory i, film f
where
r.inventory_id = i.inventory_id
and i.film_id=f.film_id
group by f.film_id;



select a.actor_id,concat(a.first_name," ",a.last_name), sum(rpf.total_revenue) total_revenue_per_actor
from revenue_per_film rpf, actor a, film_actor fa
where rpf.film_id=fa.film_id and a.actor_id=fa.actor_id
group by a.actor_id
order by total_revenue_per_actor DESC
;