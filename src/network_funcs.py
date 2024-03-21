import os
import socket
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Networking


def check_connection():
    try:
        socket.create_connection(("8.8.8.8", 53), timeout=5)
        system_logger.log_message("INFO", "Checking internet connection.")
        return 1
    except OSError:
        system_logger.log_message("FATAL", "No internet connection.")
        return 0
