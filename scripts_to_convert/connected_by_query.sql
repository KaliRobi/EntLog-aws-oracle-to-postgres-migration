select delivery_id, ent_id, level, sys_connect_by_path(ent_id, '->') as path
from deliveries
start with ent_id=1
connect by prior ent_id=ent_id;
