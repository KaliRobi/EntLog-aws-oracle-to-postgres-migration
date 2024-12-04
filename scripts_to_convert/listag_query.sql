select delivery_id, listagg(action, ', ') within group (order by timestamp) as action_sequence
from delivery_log
group by delivery_id;
