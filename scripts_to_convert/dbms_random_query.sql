select e.ent_id, e.ent_name, dbms_random.string('U', 8) as random_code, dbms_random.value(100, 1000) as random_metric
from ents e
where dbms_random.value(0, 1) > 0.5
order by random_metric desc;
