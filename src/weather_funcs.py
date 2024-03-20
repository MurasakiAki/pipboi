import requests

# Weather
def tell_weather(city):
    url = f'https://wttr.in/{city.replace(" ", "+")}?format=%t'
    response = requests.get(url)

    if response.status_code == 200:
        temperature = response.text.strip()
        return temperature
    else:
        return 'Error fetching weather data.'