import os
import subprocess
import shutil
import logging
from datetime import datetime
from multiprocessing import Pool, cpu_count

# Configuration
LOG_FILE = "conversion.log"
#better to look out for errors only
ERROR_LOG = "conversion_errors.log"


ORA2PG_CONFIG = "/ora2pg.conf"
ROOT_DIR = ""    # Probably the best approach would be to run the script based on regions (AMER, EMEA, APAC)
TRANSLATED_DIR = ""  
PSQL_USER = "psql_user"
PSQL_HOST = "psql_host"
PSQL_DB = "sql_db"     #connection string to the new db

# Logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.FileHandler(LOG_FILE),
        logging.StreamHandler()
    ]
)

def log_error(message):

#Logging for errors only

    with open(ERROR_LOG, "a") as error_log:
        error_log.write(f"{datetime.now()} [ERROR] {message}\n")
    logging.error(message)

def ensure_directories():

    if not os.path.isdir(ROOT_DIR):
        log_error(f"Root directory {ROOT_DIR} does not exist.")
        exit(1)
    
    if not os.path.isdir(TRANSLATED_DIR):
        logging.info(f"Translated directory {TRANSLATED_DIR} does not exist. Creating it...")
        os.makedirs(TRANSLATED_DIR)
    
    if not os.path.isfile(ORA2PG_CONFIG):
        log_error(f"Ora2Pg configuration file {ORA2PG_CONFIG} not found.")
        exit(1)

def convert_sql(file):
#Convert Oracle to Postgre using Ora2Pg.

    translated_file = f"{os.path.splitext(file)[0]}_translated.sql"
    logging.info(f"Converting {file}.")
    try:
        subprocess.check_call([
            "ora2pg",
            "-c", ORA2PG_CONFIG,
            "-t", "SHOW_TABLES",
            "-f", file,
            "-o", translated_file
        ])
        logging.info(f"Conversion successful for {file}")
        return translated_file
    except subprocess.CalledProcessError:
        log_error(f"Conversion failed for {file}")
        return None

# If we want to test the succesfull conversion. 
# Runs synchronously so subprocess.check_call should wait for the sql execution to be complete so we avoid overhelming the servers.
def test_sql(translated_file):

    logging.info(f"Testing translated file {translated_file} on PostgreSQL.")
    try:
        subprocess.check_call([
            "psql",
            "-U", PSQL_USER,
            "-h", PSQL_HOST,
            "-d", PSQL_DB,
            "-f", translated_file
        ], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        logging.info(f"Successfully executed SQL file {translated_file} on PostgreSQL")
        return True
    except subprocess.CalledProcessError:
        log_error(f"Failed to execute SQL file {translated_file} on PostgreSQL")
        return False

#move everything to the new location

#side note that the script paths in the bash files also need to be changed in these new files .sh files 
def move_related_files(original_file, translated_file):

    base_name = os.path.splitext(original_file)[0]
    # Move the converted  SQL file
    new_sql_path = os.path.join(TRANSLATED_DIR, os.path.basename(translated_file))
    os.rename(translated_file, new_sql_path)
    logging.info(f"Moved translated file to {new_sql_path}")

    # adding the src file.
    new_file_name = f"{base_name}.src.sql"
    new_src_path = os.path.join(TRANSLATED_DIR, new_file_name)
    
    shutil.copy(translated_file, new_src_path)
    # move the bash file
    related_sh_file = f"{base_name}.sh"
    if os.path.isfile(related_sh_file):
        new_sh_path = os.path.join(TRANSLATED_DIR, os.path.basename(related_sh_file))
        os.rename(related_sh_file, new_sh_path)
        logging.info(f"Moved related .sh file to {new_sh_path}")



# Orcestarte all the previosu
def process_file(file):
    """Process a single SQL file."""
    if file.endswith(".sh"):
        # Skip .sh files
        return
    
    logging.info(f"Processing file: {file}")
    translated_file = convert_sql(file)

    #If testing is not needed then we can just remove this.
    if translated_file:
        if test_sql(translated_file):
            move_related_files(file, translated_file)
        else:
            log_error(f"SQL test failed for {file}")
    else:
        log_error(f"Conversion failed for {file}")

def main():
    ensure_directories()
    
    sql_files = [
        os.path.join(root, file)
        for root, _, files in os.walk(ROOT_DIR)
        for file in files if file.endswith(".sql")
    ]
    
    if not sql_files:
        logging.info("No SQL files found.")
        return

    # Using paralell execution to make it a bit faster
    with Pool(cpu_count()) as pool:
        pool.map(process_file, sql_files)

    logging.info("Processing completed. Check logs for details.")

if __name__ == "__main__":
    main()
