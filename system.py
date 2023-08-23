from datetime import date
from datetime import datetime
import bcrypt
import random
import requests
from geopy.geocoders import Nominatim
import geocoder
import json

# normal 0-2
# love 3-5
# surprise 6-8
# disappointment 9-11
# sad 12-14
# angry 15-17
emotions = ["'V'", ">v<", "◠‿◠", "¬‿¬✿", "◕ω◕✿", "｡♥‿♥｡", "☉_☉", "'o'", "⊙△⊙", "<_<", "¬_¬", "⌣_⌣”", "QvQ", "ಥ﹏ಥ", "╥﹏╥", "╬ Ò﹏Ó", "=_=", "⋋▂⋌"]

# Emotions
def random_emotion():
    rnd_emotion = random.choice(emotions)
    return rnd_emotion

def gen_normal():
    i = random.randint(0, 2)

    return emotions[i]

def gen_love():
    i = random.randint(3, 5)

    return emotions[i]

def gen_surprise():
    i = random.randint(6, 8)

    return emotions[i]

def gen_disappointment():
    i = random.randint(9, 11)

    return emotions[i]

def gen_sad():
    i = random.randint(12, 14)

    return emotions[i]

def gen_angry():
    i = random.randint(15, 17)

    return emotions[i]


# Time
def tell_time():
    t = datetime.now()

    # H:M:S
    current_time = t.strftime("%H:%M:%S")
    
    return f"It's {current_time}"


def tell_day():
    today = date.today()

    # dd/mm/YY
    current_day = today.strftime("%d/%m/%Y")
    
    return f"Today is {current_day}"

def tell_dt():
    now = datetime.now()

    # dd/mm/YY H:M:S
    dt_string = now.strftime("%d/%m/%Y %H:%M:%S")

    return f"It's {dt_string}"

# Geological stuff
def is_valid_city(city_name):
    geolocator = Nominatim(user_agent="city-checker")
    location = geolocator.geocode(city_name)
    
    if location:
        return True
    else:
        return False

def tell_latitude():
    location = geocoder.ip('me')

    return location.latlng[0]

def tell_longitude():
    location = geocoder.ip('me')

    return location.latlng[1]

def tell_location(username):
    location = geocoder.ip('me')
    
    try:
        with open(f".{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        data = {'locations': []}

    matching_location = None
    
    for loc in data['locations']:
        if loc['latitude'] == str(location.latlng[0]) and loc['longitude'] == str(location.latlng[1]):
            matching_location = loc
            break
        
    if matching_location:
        return f"You are at {matching_location['name']}"
    else:
        return f"Your location is: {location.country}, {location.city}, {location.latlng[0]}/{location.latlng[1]}"

def whereip(ip_add):
    location = geocoder.ip(ip_add)

    if location.ok:
        return f"Location of {ip_add} is: {location.country}, {location.city}, {location.latlng[0]}/{location.latlng[1]}"
    else:
        return f"Unable to locate {ip_add}"

def whereloc(username, name):
    try:
        with open(f".{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        return f"Error: .{username}/.locations.json not found."
        
    for location in data.get("locations", []):
        if location.get("name") == name:
            latitude = location.get("latitude")
            longitude = location.get("longitude")
            if latitude is not None and longitude is not None:
                return f"Location {name} is at {latitude}/{longitude}"
                break
            else:
                return f"Location '{name}' has incomplete data."
    return f"{name} not found"

def add_location(username, name, latitude, longitude):
    try:
        with open(f".{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        data = {'locations': []}

    new_location = {
        'name': name,
        'latitude': latitude,
        'longitude': longitude
    }
    data['locations'].append(new_location)

    with open(f".{username}/.locations.json", 'w') as file:
        json.dump(data, file, indent=4)
        return "New location added successfully."

def remove_location(username, name):
    try:
        with open(f".{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        return "File not found"

    # Find the location with the given name and remove it
    locations = data.get('locations', [])
    updated_locations = [loc for loc in locations if loc.get('name') != name]
    data['locations'] = updated_locations

    # Write the updated data back to the JSON file
    with open(f".{username}/.locations.json", 'w') as file:
        json.dump(data, file, indent=4)
        return f"Location '{name}' removed successfully."

# Weather
def tell_weather(city):
    url = f'https://wttr.in/{city.replace(" ", "+")}?format=%t'
    response = requests.get(url)

    if response.status_code == 200:
        temperature = response.text.strip()
        return temperature
    else:
        return 'Error fetching weather data.'

# Password encryption
def hash_password(password):
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def check_password(input_password, hashed_password):
    return bcrypt.checkpw(input_password.encode('utf-8'), hashed_password.encode('utf-8'))