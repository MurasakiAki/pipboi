from datetime import date
from datetime import datetime
import calendar

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

def tell_y_calendar(year):
    try:
        year = int(year)
        return calendar.calendar(year)
    except ValueError:
        return "Enter correct year please"

def tell_m_calendar(year, month):
    months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    try:
        year = int(year)
        if month in months:
            month = months.index(month) + 1
        else:
            month = int(month)
        return calendar.month(year, month)
    except ValueError:
        return "Enter correct year or month please"