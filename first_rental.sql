drop temporary table if exists first_rental;
create temporary table first_rental
select r.customer_id, min(r.rental_date) first_time
from rental r 
group by 1 ; 

drop temporary table if exists cohort_size;
create temporary table cohort_size
select left(first_time, 7) month, count(*) num
from first_rental
group by 1 ;

select r.*, left(fr.first_time, 7) cohort, p.amount
from rental r, first_rental fr, cohort_size cs, payment p
where r.customer_id=fr.customer_id and
cs.month=left(fr.first_time, 7) and
p.rental_id=r.rental_id ;