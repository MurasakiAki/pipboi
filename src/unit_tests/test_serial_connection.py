import serial.tools.list_ports
import json
import os
import sys
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(project_root)
from logger import Logger

script_directory = os.path.dirname(os.path.abspath("pipboi"))
log_file_path = os.path.join(script_directory, "../logs/.test-log.txt")
unit_logger = Logger(log_file_path)

# Unit test for serial connection

config_file_path = '../conf/sens_conf.json'
with open(os.path.abspath(config_file_path), 'r') as f:
    config = json.load(f)

def is_arduino_connected(port_name):
    ports = serial.tools.list_ports.comports()
    for port, desc, hwid in sorted(ports):
        if port == port_name:
            return True
    return False

def test_ser_con():
    if 'usb_port' in config:
        arduino_port = config['usb_port']
        if is_arduino_connected(arduino_port):
            unit_logger.log_message("INFO", "Unit test - serial connection - PASSED")
            return 1
        else:
            unit_logger.log_message("WARNING", "Unit test - serial connection - NOT PASSED")
            return 0
    else:
        unit_logger.log_message("ERROR", "Error: 'usb_port' key is missing in the configuration file.")

test_ser_con()