import os
import logging

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/.internal-error-log.txt")

class Logger:
    def __init__(self, log_file):
        try:
            self.logger = logging.getLogger(log_file)
            self.logger.setLevel(logging.DEBUG)

            formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')

            file_handler = logging.FileHandler(log_file)
            file_handler.setLevel(logging.DEBUG)
            file_handler.setFormatter(formatter)

            self.logger.addHandler(file_handler)

        except FileNotFoundError:
            Logger(log_file_path).log_message("fatal", f"Error: The specified log file '{log_file}' was not found.")

    def log_message(self, level, message):
        level = level.upper()
        if level == "DEBUG":
            self.logger.log(logging.DEBUG, message)
        elif level == "INFO":
            self.logger.log(logging.INFO, message)
        elif level == "WARNING":
            self.logger.log(logging.WARNING, message)
        elif level == "ERROR":
            self.logger.log(logging.ERROR, message)
        elif level == "FATAL":
            self.logger.log(logging.FATAL, message)
        else:
            Logger(log_file_path).log_message("fatal", f"Unknown logging level on message: '{message}'")