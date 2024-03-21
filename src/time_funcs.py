import os
from datetime import date
from datetime import datetime
import calendar
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Time


def tell_time():
    try:
        t = datetime.now()

        # H:M:S
        current_time = t.strftime("%H:%M:%S")
        system_logger.log_message("INFO", "Telling time.")
        return f"It's {current_time}"
    except Exception:
        system_logger.log_message("ERROR", "Error while telling time.")
        return "Error while telling time."


def tell_day():
    try:
        today = date.today()

        # dd/mm/YY
        current_day = today.strftime("%d/%m/%Y")
        system_logger.log_message("INFO", "Telling day.")
        return f"Today is {current_day}"
    except Exception:
        system_logger.log_message("ERROR", "Error while telling day.")
        return "Error while telling day."


def tell_dt():
    try:
        now = datetime.now()

        # dd/mm/YY H:M:S
        dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
        system_logger.log_message("INFO", "Telling day-time.")
        return f"It's {dt_string}"
    except Exception:
        system_logger.log_message("ERROR", "Error while telling day-time.")
        return "Error while telling day-time."


def tell_y_calendar(year):
    try:
        year = int(year)
        system_logger.log_message("INFO", "Printing calendar - year.")
        return calendar.calendar(year)
    except ValueError:
        system_logger.log_message(
            "WARNING", "Incorect year entered while trying to print calendar - year.")
        return "Enter correct year please"


def tell_m_calendar(year, month):
    months = ["January", "February", "March", "April", "May", "June",
              "July", "August", "September", "October", "November", "December"]

    try:
        year = int(year)
        if month in months:
            month = months.index(month) + 1
        else:
            month = int(month)
        system_logger.log_message("INFO", "Printing calendar - month.")
        return calendar.month(year, month)
    except ValueError:
        system_logger.log_message(
            "WARNING", "Incorect year/month entered while trying to print calendar - month.")
        return "Enter correct year or month please"
