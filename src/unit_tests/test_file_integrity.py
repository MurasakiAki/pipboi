import os
import json
import sys
project_root = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
sys.path.append(project_root)
from logger import Logger

script_directory = os.path.dirname(os.path.abspath("pipboi"))
log_file_path = os.path.join(script_directory, "../logs/.test-log.txt")
unit_logger = Logger(log_file_path)

# Unit test for checking file integrity

def check_file(file_path):
    if os.path.exists(os.path.abspath(file_path)):
        unit_logger.log_message("INFO", f"Unit test - file integrity of {file_path} - PASSED")
        return True
    else:
        unit_logger.log_message("ERROR", f"Unit test - file integrity of {file_path} - NOT PASSED")
        return False

def test_file_integrity():
    sens_config_file_path = '../conf/sens_conf.json'
    help_file_path = '../.help.txt'
    if not check_file(sens_config_file_path):
        config = {
            "usb_port": "/dev/ttyACM0"
        }
        with open(os.path.abspath(sens_config_file_path), 'w') as f:
            json.dump(config, f, indent=4)
        unit_logger.log_message("INFO", f"Created sensor configuration file at {sens_config_file_path}")
    elif not check_file(help_file_path):
        contents = "////////////////////\nAll PIPBOI Commands\n \n//(If command entry begins with '*' character, the command is not integrated yet.)//\n \n#BASICS#\n help - displays this help file\n help [section] - displays only one section of help file\n register [name] - creates new user\n login [name] - log into your account\n whoami - tells you your name\n update - updates the PIPBOI\n quit - exits the interface\n *hello - introduction/basic quick info\n \n #TIME#\n time - tells current time\n day - tells current day\n dt - tells day and time\n calendar [type] - displays the calendar [type] is year/month \n \n #IMAGE#\n draw [img_file] - will draw image file as ascii art\n \n #WEATHER#\n weather [city name] - tells you current weather in [city name]\n \n #FILES#\n list - shows content of your user folder\n list [dir name] - shows content of [dir name]\n write [file name] - creates or writes into [file name]\n read [file name] - displays a [file name] content\n removef [file name] - removes [file name] file\n makedir - creates a directory\n removed [dir name] - removes a directory\n *goto [dir] - changes working directory\n \n #LOCATION1#\n whereami - tells you your location\n whereip [ipv4 address] - tells you location of device using [ipv4 address]\n whereloc [location name] - tells you latitude and longitude of your saved location\n addloc here - saves your current location\n addloc [lat/lng] - saves a location based on latitude and longitude\n remloc [location name] - removes a saved location\n showloc - shows saved locations\n \n #LOCATION2#\n distance [lat1, lng1, lat2, lng2] - tells you distance between two points\n distname [name, lat2, lng2] - tells you distance between saved location [name] and point [lat2, lng2]\n distnames [name1, name2] - tells you distance between two saved locations\n disthere [name|lat/lng] - tells you how far is your current location and location you choose\n getlocname [lat/lng] - tells you location name based on [lat/lng]\n getloc [name] - tells you lat/lng based on [name]\n \n #MODS#\n mods - tells you available mods\n use [mod name] - runs the [mod name]\n modinfo [mod name] - shows info about [mod name], if info.txt is in the mod\n include [folder name] - will make your folder an executable mod in PIPBOI (more in /docs/modding.md)\n *removem [mod name] - removes mod\n \n #SENSORS#\n s-dist - will measure distance\n s-temp - will measure temperature(°C)/humidity(%)\n ////////////////////"
        with open(os.path.abspath(help_file_path), 'w') as f:
            f.write(contents)
        unit_logger.log_message("INFO", f"Created help file at {help_file_path}")

test_file_integrity()