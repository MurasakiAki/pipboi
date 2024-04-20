# PIPBOI Documentation

## Description

PIPBOI is an console application for RPi wearable system, that can be used for your everyday computer needs.
It is based on Fallout's PIPBOY device that is commonly used throughout the game, PIPBOI is trying to be a replica or realistic implementation of Fallout's PIPBOY.

PIPBOI should work on any unix system that has bash/python, but its recomended to use it with the wearable setup, consisting of:

(For PIPBOI MK1.x)

- RPi 3/4/5
- Waveshare 3.5" display
- Arduino (Using UNO R4 WiFi but other can be used too)
- Ultrasound sensor (HC-SRO4)
- Temperature/humidity sensor (DHT11)
- Optional tilt sensor (SW-520D)
- Any input device(Bluetooth mini keyboard recommended)

How to build your wearable PIPBOI can be found in [Build tutorial](build.md).

## Usage

The PIPBOI is controlled through a simple command line inputs.
It is recommended to have stable internet access.

### Start

To have full access to all functions of the PIPBOI, you need to have certain Python libraries installed, plus some other setup is needed.
For this, move yourself to the pipboi directory, execute the `startup.sh` file with `chmod +x startup.sh` and `./startup.sh` a setup interface will go through the setup with you.

First, you need to register yourself with the register command `pipboi register <name>`, affter succesfully registering you can login with `pipboi login <name>`.

A user folder is created, with initial locations JSON file and data INI file, in this folder, user can create, modify and remove folders and files.

### Basics

To start using PIPBOI you'll need to learn the few commands that are implemented in PIPBOI, to see the description in interface use the `help` command, you can learn more about each command there.

## Used tools and requirements

PIPBOI is build using Bash script, Python and C++.

**Requirements:**

- Python
- Python bcrypt
- Python geopy
- Python geocoder
- Python pillow
- Python PIL

**Configuration:**

You can configure the used port for serial communication with the Arduino. Often it is a required step.

You can find the config file in `conf/sens_conf.json`.

**Design pattern**

Most of PIPBOIs functionalities comes from communicating with APIs, or other advanced functions that Bash could not accomplish. These tasks are solved using several Python scripts, Bash script then acts as a facade that provides a simplified interface to the functionality provided by the Python scripts. It performs additional checks, logging, and then delegates the work to the appropriate Python function.

**Unit tests**

After executing the `startup.sh` _or_ starting the PIPBOI, a 3 unit tests will start.
You will see on screen if test **PASSED** or not.

- `test_connection.py` will test if Internet is accessible, it is greatly recommended to have Internet access while using PIPBOI.
- `test_file_integration.py` will test if config files. help files are present.
- `test_serial_connection.py` will test if Arduino is connected, the `s-` commands will not work if Arduino is not connected.

**Logging**

PIPBOI uses my own logging system called Logger, its based on Pythons loggin library.

Logs from PIPBOI can be accessed in the `logs/system-log.txt` file, any kind of action is documented there too.
For more severe app breaking reports see `logs/.internal-error-log.txt` file.

PIPBOI has also command hostory, meaning you can press up/down arrow and the last command you typed will fill in automatically, to see these saved commands see `logs/.command_history` file. Note that this file is cleared every time the application is exited via `quit` command.
