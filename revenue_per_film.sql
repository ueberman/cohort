select f.film_id, f.title, f.rental_rate*count(*)
from rental r, inventory i, film f
where
r.inventory_id = i.inventory_id
and i.film_id=f.film_id
group by f.film_id;

