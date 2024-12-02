-- deliveries 

INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Fangorn', 'Gladden Fields', TO_DATE('2024-12-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-12 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), 5);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Isengard', 'Helms Deep', TO_DATE('2024-12-10 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-13 18:45:00', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Green Hills', 'Lake Evendim', TO_DATE('2024-12-11 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-14 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Eryn Vorn', 'Hills of Evendim', TO_DATE('2024-12-12 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-15 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Mount Gundabad', 'Carrock', TO_DATE('2024-12-13 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-16 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('North Downs', 'Ered Luin', TO_DATE('2024-12-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Emyn Muil', 'Nindalf', TO_DATE('2024-12-06 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-09 17:45:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Mirkwood', 'Dale', TO_DATE('2024-12-07 08:15:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-10 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Enedwaith', 'Eregion', TO_DATE('2024-12-08 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-11 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Fangorn', 'Rivendell', TO_DATE('2024-12-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-03 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id)  VALUES ('Fangorn', 'Shire', TO_DATE('2024-12-02 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Fangorn', 'Minas Tirith', TO_DATE('2024-12-03 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-07 11:45:00', 'YYYY-MM-DD HH24:MI:SS'), 3); 
INSERT INTO deliveries (origin, destination, departure_time, arrival_time, ent_id) VALUES ('Fangorn', 'Lothlorien', TO_DATE('2024-12-04 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-12-06 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4); 


--  delivery_log
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (5, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (5, 'Crossed Isen', SYSDATE + INTERVAL + (2/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (5, 'Reached Helms Deep', SYSDATE + INTERVAL + (3/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (6, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (6, 'Passed the Green Hills', SYSDATE + INTERVAL + (1/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (6, 'Arrived at Lake Evendim', SYSDATE + INTERVAL + (4/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (7, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (7, 'Arrived at the Hills of Evendim', SYSDATE + INTERVAL + (3/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (8, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (8, 'Arrived at Carrock', SYSDATE + INTERVAL + (3/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'En Route', SYSDATE + INTERVAL + (1/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'Arrived', SYSDATE + INTERVAL + (2/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (2, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (2, 'En Route', SYSDATE + INTERVAL + (2/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'Crossed Bree', SYSDATE + INTERVAL + (6/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (1, 'Reached Ered Luin', SYSDATE + INTERVAL + (3/24));
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (2, 'Departed', SYSDATE);
INSERT INTO delivery_log (delivery_id, action, timestamp) VALUES (2, 'Entered Dead Marshes', SYSDATE + INTERVAL + (2/24));


-- payments
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (1, 220.75, SYSDATE, 'Completed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (2, 175.50, SYSDATE, 'Completed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (3, 280.20, SYSDATE, 'Pending');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (1, 320.10, SYSDATE, 'Failed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (3, 190.40, SYSDATE, 'Completed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (2, 150.00, SYSDATE, 'Pending');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (1, 210.40, SYSDATE, 'Completed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (2, 180.30, SYSDATE, 'Pending');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (3, 310.75, SYSDATE, 'Failed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (1, 200.50, SYSDATE, 'Completed');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (2, 150.75, SYSDATE, 'Pending');
INSERT INTO payments (client_id, amount, payment_date, payment_status) VALUES (3, 300.00, SYSDATE, 'Failed');


-- ents
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Oaklimb', 'Fangorn', 2200, 18, 'Active');
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Rowanleaf', 'Fangorn', 1300, 12, 'Active');
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Birchroot', 'Fangorn', 900, 10, 'Resting');
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Maplebough', 'Fangorn', 1500, 14, 'Active');
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Cedarheart', 'Fangorn', 1700, 16, 'Inactive');
INSERT INTO ents (ent_name, ent_location, age, height, status) VALUES ('Willowwhisper', 'Fangorn', 2000, 17, 'Active');




-- 'forest_clients' 
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Dwarves of Ered Luin', 'Gloin', 'gloin@eredluin.net', '222-333-4444');
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Marshfolk of Nindalf', 'Frodrig', 'frodrig@marshfolk.co', '333-444-5555');
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Men of Dale', 'Girion', 'girion@dale.gov', '444-555-6666');
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Elves of Rivendell', 'Elrond', 'elrond@rivendell.com', '123-456-7890');
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Hobbits of the Shire', 'Frodo Baggins', 'frodo@shiremail.com', '987-654-3210');
INSERT INTO forest_clients (client_name, contact_name, contact_email, contact_phone) VALUES ('Men of Gondor', 'Aragorn', 'aragorn@gondor.gov', '555-555-5555');


-- 'treestumps' 
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Old Stump', 1, 150.75, 'Ent-Draught');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Young Stump', 2, 120.50, 'Healing Herbs');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Rough Stump', 3, 180.25, 'Saplings');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Broad Stump', 4, 200.00, 'Rare Seeds');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Tall Stump', 1, 170.60, 'Exotic Plants');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Mossy Stump', 5, 110.40, 'Medicinal Bark');
INSERT INTO treestumps (stump_name, ent_id, weight, contents) VALUES ('Frosty Stump', 6, 145.70, 'Crystalline Sap');

