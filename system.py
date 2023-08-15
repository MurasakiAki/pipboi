from datetime import date
from datetime import datetime
import bcrypt

#Time
def tell_time():
    t = datetime.now()
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

#Password encryption
def hash_password(password):
    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), salt)
    return hashed_password.decode('utf-8')

def check_password(input_password, hashed_password):
    return bcrypt.checkpw(input_password.encode('utf-8'), hashed_password.encode('utf-8'))