import os
import requests
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Weather


def tell_weather(city):
    try:
        url = f'https://wttr.in/{city.replace(" ", "+")}?format=%t'
        response = requests.get(url)

        if response.status_code == 200:
            temperature = response.text.strip()
            system_logger.log_message("INFO", f"Telling temperature in {city}")
            return temperature
    except Exception:
        system_logger.log_message("ERROR", 'Error fetching weather data.')
        return 'Error fetching weather data.'
