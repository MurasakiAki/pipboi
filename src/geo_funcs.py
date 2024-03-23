import os
from geopy.geocoders import Nominatim
from geopy.distance import geodesic
import geocoder
import json
import requests
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Geological stuff


def is_valid_city(city_name):
    try:
        geolocator = Nominatim(user_agent="city-checker")
        location = geolocator.geocode(city_name)

        system_logger.log_message("INFO", "Checking city validity.")

        if location:
            return True
        else:
            return False
    except Exception as e:
        system_logger.log_message(
            "ERROR", f"Error checking city validity: {str(e)}")
        return False


def tell_latitude():
    try:
        location = geocoder.ip('me')

        system_logger.log_message("INFO", "Telling latitude.")
        return location.latlng[0]
    except Exception as e:
        system_logger.log_message("ERROR", f"Error telling latitude: {str(e)}")
        return None


def tell_longitude():
    try:
        location = geocoder.ip('me')

        system_logger.log_message("INFO", "Telling longitude.")
        return location.latlng[1]
    except Exception as e:
        system_logger.log_message(
            "ERROR", f"Error telling longitude: {str(e)}")
        return None


def tell_location(username):
    try:
        location = geocoder.ip('me')

        with open(f"../.{username}/.locations.json", 'r') as file:
            data = json.load(file)

        matching_location = None

        for loc in data['locations']:
            if loc['latitude'] == str(location.latlng[0]) and loc['longitude'] == str(location.latlng[1]):
                matching_location = loc
                break

        system_logger.log_message("INFO", "Telling location.")
        if matching_location:
            return f"You are at {matching_location['name']}"
        else:
            return f"Your location is: {location.country}, {location.city}, {location.latlng[0]}/{location.latlng[1]}"
    except Exception as e:
        system_logger.log_message("ERROR", f"Error telling location: {str(e)}")
        return None


def whereip(ip_add):
    location = geocoder.ip(ip_add)

    if location.ok:
        system_logger.log_message("INFO", "Telling location based on IP.")
        return f"Location of {ip_add} is: {location.country}, {location.city}, {location.latlng[0]}/{location.latlng[1]}"
    else:
        system_logger.log_message("ERROR", "IP address not found.")
        return f"Unable to locate {ip_add}"


def whereloc(username, name):
    try:
        with open(f"../.{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message("ERROR", "File locations.json not found.")
        return f"Error: .{username}/.locations.json not found."

    for location in data.get("locations", []):
        if location.get("name") == name:
            latitude = location.get("latitude")
            longitude = location.get("longitude")
            if latitude is not None and longitude is not None:
                system_logger.log_message(
                    "INFO", "Telling location based on name.")
                return f"Location {name} is at {latitude}/{longitude}"
                break
            else:
                system_logger.log_message(
                    "WARNING", f"Location '{name}' has incomplete data.")
                return f"Location '{name}' has incomplete data."
    return f"{name} not found"


def add_location(username, name, latitude, longitude):
    try:
        with open(f"../.{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "WARNING", "File locations.json missing/not found.")
        data = {'locations': []}

    new_location = {
        'name': name,
        'latitude': latitude,
        'longitude': longitude
    }
    data['locations'].append(new_location)

    with open(f"../.{username}/.locations.json", 'w') as file:
        json.dump(data, file, indent=4)
        system_logger.log_message("INFO", "New location added successfully.")
        return "New location added successfully."


def remove_location(username, name):
    try:
        with open(f"../.{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "ERROR", "File locations.json missing/not found.")
        return "File not found"

    # Find the location with the given name and remove it
    locations = data.get('locations', [])
    updated_locations = [loc for loc in locations if loc.get('name') != name]
    data['locations'] = updated_locations

    # Write the updated data back to the JSON file
    with open(f"../.{username}/.locations.json", 'w') as file:
        json.dump(data, file, indent=4)
        system_logger.log_message(
            "INFO", f"Location '{name}' removed successfully.")
        return f"Location '{name}' removed successfully."


def show_location(username):
    try:
        with open(f"../.{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "ERROR", "File locations.json missing/not found.")
        return "File not found"

    saved_locations = []

    for loc in data.get("locations", []):
        name = loc.get("name")
        lat = loc.get("latitude")
        lng = loc.get("longitude")
        saved_locations.append(f"{name}, {lat}/{lng}")

    if saved_locations is None:
        system_logger.log_message("WARNING", "No saved locations.")
        return "No saved locations"
    else:
        system_logger.log_message("INFO", "Telling saved locations.")
        return saved_locations


def distance(lat1, lng1, lat2, lng2):
    loc1 = (lat1, lng1)
    loc2 = (lat2, lng2)

    dist = geodesic(loc1, loc2).kilometers

    system_logger.log_message(
        "INFO", f"Telling distance between {lat1}/{lng1} and {lat2}/{lng2}.")
    return f"Distance between {lat1}/{lng1} and {lat2}/{lng2} is {dist:.3f} km"


def distname(username, name, lat2, lng2):
    lat1 = None
    lng1 = None
    try:
        with open(f"../.{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "ERROR", "File locations.json missing/not found.")
        return f"Error: .{username}/.locations.json not found."

    for location in data.get("locations", []):
        if location.get("name") == name:
            latitude = location.get("latitude")
            longitude = location.get("longitude")
            if latitude is not None and longitude is not None:
                loc1 = (latitude, longitude)
                loc2 = (lat2, lng2)

                dist = geodesic(loc1, loc2).kilometers
                system_logger.log_message(
                    "INFO", f"Telling distance between {name} and {lat2}/{lng2}.")
                return f"Distance between {name} and {lat2}/{lng2} is {dist:.3f} km"
                break
            else:
                system_logger.log_message(
                    "WARNING", f"Location '{name}' has incomplete data.")
                return f"Location '{name}' has incomplete data."
    return f"{name} not found"


def distnames(username, name1, name2):
    lat1 = None
    lng1 = None
    lat2 = None
    lng2 = None
    try:
        with open(f"../.{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "ERROR", "File locations.json missing/not found.")
        return f"Error: .{username}/.locations.json not found."

    for location in data.get("locations", []):
        if location.get("name") == name1:
            lat1 = location.get("latitude")
            lng1 = location.get("longitude")
        elif location.get("name") == name2:
            lat2 = location.get("latitude")
            lng2 = location.get("longitude")

        if lat1 is not None and lng1 is not None and lat2 is not None and lng2 is not None:
            loc1 = (lat1, lng1)
            loc2 = (lat2, lng2)

            dist = geodesic(loc1, loc2).kilometers
            system_logger.log_message(
                "INFO", f"Distance between {name1} and {name2} is")
            return f"Distance between {name1} and {name2} is {dist:.3f} km"
    return f"{name1} or {name2} not found"


def disthere(username, input):
    name = None
    lat2 = None
    lng2 = None

    try:
        with open(f"../.{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        system_logger.log_message(
            "ERROR", "File locations.json missing/not found.")
        return f"Error: .{username}/.locations.json not found."

    if "/" in input:
        parts = input.split("/")
        if len(parts) == 2:
            try:
                lat2 = float(parts[0])
                lng2 = float(parts[1])
            except ValueError:
                pass
    else:
        name = input
        for loc in data.get("locations", []):
            if loc.get("name") == name:
                lat2 = loc.get("latitude")
                lng2 = loc.get("longitude")
                break

    if lat2 is None or lng2 is None:
        system_logger.log_message("ERROR", "Location not found.")
        return "Location not found."

    system_logger.log_message(
        "INFO", f"Telling distance from here to {input}.")
    return distance(tell_latitude(), tell_longitude(), lat2, lng2)

def get_lat_lng(location_name):
    base_url = "https://nominatim.openstreetmap.org/search"
    params = {
        "q": location_name,
        "format": "json",
    }
    try:
        response = requests.get(base_url, params=params)
        data = response.json()
        if data:
            # Extracting latitude and longitude from the response
            lat = float(data[0]['lat'])
            lon = float(data[0]['lon'])
            system_logger.log_message("INFO", f"Getting lat/lng of {location_name}.")
            return lat, lon
        else:
            system_logger.log_message("ERROR", "Location not found.")
            return None, None
    except Exception as e:
        system_logger.log_message("ERROR", f"{e}")
        return None, None

def get_location_name(latitude, longitude):
    base_url = "https://nominatim.openstreetmap.org/reverse"
    lat = float(latitude)
    lng = float(longitude)
    params = {
        "format": "json",
        "lat": lat,
        "lon": lng,
    }
    try:
        response = requests.get(base_url, params=params)
        data = response.json()
        if 'display_name' in data:
            address_parts = data['display_name'].split(',')
            system_logger.log_message("INFO", f"Getting name of {lat}/{lng}.")
            return f"{address_parts[1].strip()} {address_parts[0].strip()}"
        else:
            system_logger.log_message("ERROR", "Location not found.")
            return None
    except Exception as e:
        system_logger.log_message("ERROR", f"{e}")
        return None
