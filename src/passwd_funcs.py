import os
import sys
sys.path.append("vendor/python_dep")
import bcrypt
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Password encryption


def hash_password(password):
    try:
        salt = bcrypt.gensalt()
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
        system_logger.log_message("INFO", "Hashing password.")
        return hashed_password.decode('utf-8')
    except Exception:
        system_logger.log_message("ERROR", "Error with password hashing.")
        return "Error with password hashing."


def check_password(input_password, hashed_password):
    try:
        system_logger.log_message("INFO", "Checking password.")
        return bcrypt.checkpw(input_password.encode('utf-8'), hashed_password.encode('utf-8'))
    except Exception:
        system_logger.log_message("ERROR", "Error while checking password.")
        return "Error while checking password."
