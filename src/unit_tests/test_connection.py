import socket
import os
import sys
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(project_root)
from logger import Logger

script_directory = os.path.dirname(os.path.abspath("pipboi"))
log_file_path = os.path.join(script_directory, "../logs/.test-log.txt")
unit_logger = Logger(log_file_path)

# Unit test for internet connection

def test_con():
    try:
        socket.create_connection(("8.8.8.8", 53), timeout=5)
        unit_logger.log_message("INFO", "Unit test - internet connection - PASSED")
    except OSError:
        unit_logger.log_message("ERROR", "Unit test - internet connection - NOT PASSED")
        unit_logger.log_message("WARNING", "Internet connection is recomended for full functionality of PIPBOI")

test_con()