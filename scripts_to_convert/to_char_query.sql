select delivery_id, ent_id, to_char(departure_time, 'YYYY-MM-DD HH24:MI:SS') as formatted_departure,
decode(arrival_time, null, 'In Transit', 'Delivered') as status
from deliveries;
