import os
import subprocess
import shutil
import logging
from datetime import datetime
from multiprocessing import Pool, cpu_count


#This is our conrol panel here

LOG_FILE = "conversion.log"
ERROR_LOG = "conversion_errors.log"

ORA2PG_CONFIG = "ora2pg.conf"
ROOT_DIR = "/"  # Probably the best approach would be to run the script based on regions (AMER, EMEA, APAC)
TRANSLATED_DIR = ""
PSQL_USER = "psql_user"
PSQL_HOST = "psql_host"
PSQL_DB = "ypsql_db"  # connection string to the db

# AWS SCT config.
AWS_SCT_CLI = "aws"
SCT_COMMAND = "sct"
SCT_ACTION = "convert"
SOURCE_DB_TYPE = "oracle"
TARGET_DB_TYPE = "postgresql"
SOURCE_DB_HOST = "oracle_host"
SOURCE_DB_PORT = "1521"  # Oracle default port
SOURCE_DB_USER = "oracle_user"
SOURCE_DB_PASSWORD = "oracle_password"
TARGET_DB_HOST = PSQL_HOST
TARGET_DB_PORT = "5432"  # PostgreSQL default port
TARGET_DB_USER = PSQL_USER
TARGET_DB_PASSWORD = "postgresql_password"
OUTPUT_DIR = TRANSLATED_DIR

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
    # Logging for errors only
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

# we can use using AWS SCT instead of Ora2Pg. This product checks boths schemas and tests the translated script so no need for a separate function.
def convert_sql(file):

    translated_file = f"{os.path.splitext(file)[0]}_postgresql.sql"
    logging.info(f"Converting {file}.")

    try:
        subprocess.check_call([
            AWS_SCT_CLI, SCT_COMMAND, SCT_ACTION,  
            "--source-database-type", SOURCE_DB_TYPE,
            "--target-database-type", TARGET_DB_TYPE,
            "--source-database-host", SOURCE_DB_HOST,
            "--source-database-port", SOURCE_DB_PORT,
            "--source-database-user", SOURCE_DB_USER,
            "--source-database-password", SOURCE_DB_PASSWORD,
            "--target-database-host", TARGET_DB_HOST,
            "--target-database-port", TARGET_DB_PORT,
            "--target-database-user", TARGET_DB_USER,
            "--target-database-password", TARGET_DB_PASSWORD,
            "--output-dir", OUTPUT_DIR,
            "--input-file", file  # Path to the Oracle SQL file to convert
        ])
        logging.info(f"Conversion successful for {file}")
        return translated_file
    except subprocess.CalledProcessError:
        log_error(f"Conversion failed for {file}")
        return None

def move_related_files(original_file, translated_file):
    base_name = os.path.splitext(original_file)[0]

    # Move the converted SQL file
    new_sql_path = os.path.join(TRANSLATED_DIR, os.path.basename(translated_file))
    os.rename(translated_file, new_sql_path)
    logging.info(f"Moved translated file to {new_sql_path}")

    # Adding the src file
    new_file_name = f"{base_name}.src.sql"
    new_src_path = os.path.join(TRANSLATED_DIR, new_file_name)
    
    shutil.copy(translated_file, new_src_path)

    # Move the bash file
    related_sh_file = f"{base_name}.sh"
    if os.path.isfile(related_sh_file):
        new_sh_path = os.path.join(TRANSLATED_DIR, os.path.basename(related_sh_file))
        os.rename(related_sh_file, new_sh_path)
        logging.info(f"Moved related .sh file to {new_sh_path}")

def process_file(file):
    if file.endswith(".sh"):
        # Skip .sh files
        return

    logging.info(f"Processing file: {file}")
    translated_file = convert_sql(file)

    if translated_file:
        move_related_files(file, translated_file)
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

    # Using parallel execution to speed up the process
    with Pool(cpu_count()) as pool:
        pool.map(process_file, sql_files)

    logging.info("Processing completed. Check logs for details.")

if __name__ == "__main__":
    main()
