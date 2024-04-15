import serial
import time
import os
import json
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Load USB port from sens_conf.json
config_file_path = os.path.join(script_directory, "../conf/sens_conf.json")
with open(config_file_path) as config_file:
    config_data = json.load(config_file)
    usb_port = config_data.get("usb_port")

ser = serial.Serial(usb_port, 9600)

def send_job_idle():
    try:
        ser.write(b'0')
        system_logger.log_message("INFO", "Sending idle job request.")
    except Exception as e:
        system_logger.log_message("ERROR", f"Error sending idle job request: {e}")

def send_job_dist():
    try:
        ser.write(b'1')
        system_logger.log_message("INFO", "Sending distance job request.")
    except Exception as e:
        system_logger.log_message("ERROR", f"Error sending distance job request: {e}")

def send_job_temp():
    try:
        ser.write(b'2')
        system_logger.log_message("INFO", "Sending temperature/humidity job request.")
    except Exception as e:
        system_logger.log_message("ERROR", f"Error sending temperature/humidity job request: {e}")

def send_job_tilt():
    try:
        ser.write(b'3')
        system_logger.log_message("INFO", "Sending tilt job request.")
    except Exception as e:
        system_logger.log_message("ERROR", f"Error sending tilt job request: {e}")