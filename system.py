from datetime import date
from datetime import datetime
import bcrypt
import random
import requests
from geopy.geocoders import Nominatim
from geopy.distance import geodesic
import geocoder
import json
from PIL import Image

# normal 0-2
# love 3-5
# surprise 6-8
# disappointment 9-11
# sad 12-14
# angry 15-17
emotions = ["'V'", ">v<", "◠‿◠", "¬‿¬✿", "◕ω◕✿", "｡♥‿♥｡", "☉_☉", "'o'", "⊙△⊙", "<_<", "¬_¬", "⌣_⌣”", "QvQ", "ಥ﹏ಥ", "╥﹏╥", "╬ Ò﹏Ó", "=_=", "⋋▂⋌"]
farewells = ["Bye", "Bye bye!", "Have a good day!", "See you soon!", "See ya!"]

# Emotions
def random_emotion():
     
    return random.choice(emotions)

def gen_normal():

    return emotions[random.randint(0, 2)]

def gen_love():

    return emotions[random.randint(3, 5)]

def gen_surprise():
    
    return emotions[random.randint(6, 8)]

def gen_disappointment():

    return emotions[random.randint(9, 11)]

def gen_sad():

    return emotions[random.randint(12, 14)]

def gen_angry():
    
    return emotions[random.randint(15, 17)]

#Greetings/Farewells
def rnd_farewell():

    return random.choice(farewells)

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

def show_location(username):
    try:
        with open(f".{username}/.locations.json", 'r') as file:
            data = json.load(file)
    except FileNotFoundError:
        return "File not found"
    
    saved_locations = []

    for loc in data.get("locations", []):
        name = loc.get("name")
        lat = loc.get("latitude")
        lng = loc.get("longitude")
        saved_locations.append( f"{name}, {lat}/{lng}")
    
    if saved_locations is None:
        return "No saved locations"
    else:
        return saved_locations

def distance(lat1, lng1, lat2, lng2):
    loc1 = (lat1, lng1)
    loc2 = (lat2, lng2)

    dist = geodesic(loc1, loc2).kilometers

    return f"Distance between {lat1}/{lng1} and {lat2}/{lng2} is {dist:.3f} km"

def distname(username, name, lat2, lng2):
    lat1 = None
    lng1 = None
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
                loc1 = (latitude, longitude)
                loc2 = (lat2, lng2)

                dist = geodesic(loc1, loc2).kilometers

                return f"Distance between {name} and {lat2}/{lng2} is {dist:.3f} km"
                break
            else:
                return f"Location '{name}' has incomplete data."
    return f"{name} not found"

def distnames(username, name1, name2):
    lat1 = None
    lng1 = None
    lat2 = None
    lng2 = None
    try:
        with open(f".{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
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

            return f"Distance between {name1} and {name2} is {dist:.3f} km"
    return f"{name1} or {name2} not found"

def disthere(username, input):
    name = None
    lat2 = None
    lng2 = None

    try:
        with open(f".{username}/.locations.json", "r") as file:
            data = json.load(file)
    except FileNotFoundError:
        return f"Error: .{username}/.locations.json not found."

    if "/" in input:
        parts = input.split("/")
        if len(parts) == 2:
            try:
                lat2 = float(parts[0])
                lng2 = float(parts[1])
            except ValueError:
                name = input
    
    if name is not None:
        for loc in data.get("locations", []):
            if loc.get("name") == name:
                return distname(username, name, tell_latitude(), tell_longitude())
    
    else:
        return distance(tell_latitude(), tell_longitude(), lat2, lng2)
        
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

#Image
def image_to_ascii(username, image_path, width=35):
    image = Image.open(f".{username}/{image_path}")
    original_width, original_height = image.size
    aspect_ratio = original_height / original_width
    new_height = int(aspect_ratio * width * 0.55)

    resized_image = image.resize((width, new_height))
    grayscale_image = resized_image.convert("L")

    ascii_chars = "@%#*+=-:. "
    ascii_chars = ascii_chars[::-1]  # Reverse the character set for better contrast

    ascii_art = ""
    for pixel_value in grayscale_image.getdata():
        ascii_index = pixel_value * (len(ascii_chars) - 1) // 255
        ascii_art += ascii_chars[ascii_index]

    lines = [ascii_art[i:i + width] for i in range(0, len(ascii_art), width)]
    ascii_art = "\n".join(lines)

    return ascii_art

print(disthere("aki", "Home"))