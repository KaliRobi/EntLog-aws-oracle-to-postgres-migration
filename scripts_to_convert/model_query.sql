select origin, destination, duration
from (select origin, destination, arrival_time - departure_time as duration from deliveries)
model
dimension by (rownum as rn)
measures (duration)
rules iterate (5) (
duration[iteration_number] = duration[iteration_number - 1] * 1.1
);
