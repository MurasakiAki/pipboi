#!/bin/bash

# Change the permission of the pipboi script to executable
sudo chmod u+x pipboi

# Add the current directory to the PATH variable
export PATH=$PATH:$(pwd)

# Save the updated PATH variable to the bashrc or profile file - depends on the system
if [ -f "$HOME/.bashrc" ]; then
    echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
elif [ -f "$HOME/.profile" ]; then
    echo "export PATH=\$PATH:$(pwd)" >> ~/.profile
fi

# Installing Python libraries
sudo apt install pip
libraries=("bcrypt" "geopy" "geocoder")

for library in "${libraries[@]}"; do
    pip install "$library"
done

echo "Your pipboi is all set up."