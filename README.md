# PIPBOI

**_MK1.0_**

A PIPBOI system for RPi.

**_PIPBOI_** stands for:

Pigeon Integrated Personal Biometric and Operational Interface

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

How to build your wearable PIPBOI can be found in [Build tutorial](docs/build.md).

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
