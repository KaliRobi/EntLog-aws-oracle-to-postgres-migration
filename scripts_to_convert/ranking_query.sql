select e.ent_name, sum(t.weight) as total_weight, rank() over (order by sum(t.weight) desc) as weight_rank
from ents e
join treestumps t on e.ent_id=t.ent_id
group by e.ent_name;
