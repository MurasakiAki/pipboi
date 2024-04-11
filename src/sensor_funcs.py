import serial
import time
import os
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Controls the sensors

ser = serial.Serial('/dev/ttyACM0', 9600)


def send_job_idle():
    try:
        ser.write(b'0')
        system_logger.log_message("INFO", "Sending idle job request.")
    except:
        system_logger.log_message("ERROR", "Error sending idle job request.")


def send_job_dist():
    try:
        ser.write(b'1')
        system_logger.log_message("INFO", "Sending distance job request.")
    except:
        system_logger.log_message(
            "ERROR", "Error sending distance job request.")


def send_job_temp():
    try:
        ser.write(b'2')
        system_logger.log_message(
            "INFO", "Sending temperature/humidity job request.")
    except:
        system_logger.log_message(
            "ERROR", "Error sending temperature/humidity job request.")


def send_job_tilt():
    try:
        ser.write(b'3')
        system_logger.log_message("INFO", "Sending tilt job request.")
    except:
        system_logger.log_message("ERROR", "Error sending tilt job request.")
