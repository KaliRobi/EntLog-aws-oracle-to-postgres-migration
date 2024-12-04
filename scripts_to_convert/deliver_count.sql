select * from (
select origin, destination, case when arrival_time < sysdate then 'Completed' else 'In Progress' end as status
from deliveries
)
pivot (count(status) for status in ('Completed', 'In Progress'));
