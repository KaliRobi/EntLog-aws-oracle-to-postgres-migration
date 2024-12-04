select * from (select client_name, contact_email from forest_clients order by client_name) where rownum <= 10;
