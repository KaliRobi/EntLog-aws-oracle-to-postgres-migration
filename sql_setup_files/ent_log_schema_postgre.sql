-- Creating the EntLog Schema for the Middle-earth Freight Service (PostgreSQL version)
-- The business is managed by the real heroes of Middle Earth, the Ents.

-- Create the schema
CREATE SCHEMA entlog;

-- Set the search path 
SET search_path TO entlog;

-- Table: Ents
-- Ents, who are the true carriers of the forest (business profile: reliable, bit slow)
CREATE TABLE ents (
    ent_id SERIAL PRIMARY KEY, 
    ent_name VARCHAR(100) NOT NULL, 
    ent_location VARCHAR(100), 
    age INTEGER, 
    height INTEGER, 
    status VARCHAR(50) DEFAULT 'Active' 
);

-- Index on ent_name to search for Ents by name
CREATE INDEX idx_ents_name ON ents(ent_name);

-- Table: Treestumps
-- Treestumps are containers that carry goods like saplings, herbs, trees sometime bushes too
CREATE TABLE treestumps (
    stump_id SERIAL PRIMARY KEY, 
    stump_name VARCHAR(100) NOT NULL, 
    ent_id INTEGER, 
    weight DECIMAL(10, 2), 
    contents VARCHAR(255), 
    FOREIGN KEY (ent_id) REFERENCES ents(ent_id)
);

-- Index on contents for searching specific items in the treestumps
CREATE INDEX idx_treestumps_contents ON treestumps(contents);

-- Table: Deliveries
-- A record of deliveries made by the Ents
CREATE TABLE deliveries (
    delivery_id SERIAL PRIMARY KEY, -- 
    origin VARCHAR(100), 
    destination VARCHAR(100), 
    departure_time TIMESTAMP,
    arrival_time TIMESTAMP, 
    ent_id INTEGER, 
    FOREIGN KEY (ent_id) REFERENCES ents(ent_id)
);

-- Index on origin and destination for fast delivery lookup
CREATE INDEX idx_deliveries_origin_dest ON deliveries(origin, destination);

-- Table: Delivery_Log
-- A log that records each step the Ents take, from INIT to POD
CREATE TABLE delivery_log (
    log_id SERIAL PRIMARY KEY, 
    delivery_id INTEGER, 
    action VARCHAR(50), 
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (delivery_id) REFERENCES deliveries(delivery_id)
);

-- Index on timestamp for fast log retrieval
CREATE INDEX idx_delivery_log_timestamp ON delivery_log(timestamp);

-- Table: Forest_Clients
-- The entities who request deliveries of goods
CREATE TABLE forest_clients (
    client_id SERIAL PRIMARY KEY, 
    client_name VARCHAR(100), 
    contact_name VARCHAR(100), 
    contact_email VARCHAR(100), 
    contact_phone VARCHAR(50) 
);

-- Table: Payments
-- Payment for delivered stuff across Middle-earth.
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY, 
    client_id INTEGER, 
    amount DECIMAL(10, 2), 
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    payment_status VARCHAR(50) DEFAULT 'Pending', 
    FOREIGN KEY (client_id) REFERENCES forest_clients(client_id)
);

-- Index on payment_status for quickly filtering payments
CREATE INDEX idx_payments_status ON payments(payment_status);


COMMIT;


