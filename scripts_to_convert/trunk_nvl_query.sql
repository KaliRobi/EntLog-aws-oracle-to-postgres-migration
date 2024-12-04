select delivery_id, trunc(departure_time) as departure_date, trunc(arrival_time) as arrival_date, 
nvl(arrival_time - departure_time, 0) as duration_in_days
from deliveries;
