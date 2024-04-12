import os
import sys
sys.path.append("vendor/python_dep")
from PIL import Image
from logger import Logger

script_directory = os.path.dirname(os.path.abspath(__file__))
log_file_path = os.path.join(script_directory, "../logs/system-log.txt")
system_logger = Logger(log_file_path)

# Image


def is_image_file(file_path):
    try:
        system_logger.log_message("INFO", "Checking if file is image (.png, .jpeg, .jpg).")
        with Image.open(file_path) as img:
            return img.format.lower() in ['png', 'jpeg', 'jpg']
    except (IOError, OSError):
        system_logger.log_message("ERROR", "File is not an image file (.png, .jpeg, .jpg).")
        return False

def image_to_ascii(username, image_path, width=32):
    try:
        path = f"../.{username}/{image_path}"
        if is_image_file(path):
            image = Image.open(f".{username}/{image_path}")
        else:
            return f"File is not an image file (.png, .jpeg, .jpg)."
    except FileNotFoundError:
        system_logger.log_message("ERROR", f"File {image_path} not found.")
        return f"File {image_path} not found."
    original_width, original_height = image.size
    aspect_ratio = original_height / original_width
    new_height = int(aspect_ratio * width * 0.55)

    resized_image = image.resize((width, new_height))
    grayscale_image = resized_image.convert("L")

    # Use a larger character set with varying shades
    ascii_chars = "@#*/)-_+~<!;:,."

    ascii_art = ""
    for pixel_value in grayscale_image.getdata():
        # Scale pixel value to the range of the character set
        ascii_index = int(pixel_value * (len(ascii_chars) - 1) / 255)
        ascii_art += ascii_chars[ascii_index]

    lines = [ascii_art[i:i + width] for i in range(0, len(ascii_art), width)]
    ascii_art = "\n".join(lines)

    system_logger.log_message("INFO", "Printing image.")
    return ascii_art
