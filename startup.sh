#!/bin/bash

# Change the permission of the system.py and pipboi scripts to be executable
sudo chmod u+x system.py
sudo chmod u+x pipboi

# Add the current directory to the PATH variable
export PATH=$PATH:$(pwd)

# Save the updated PATH variable to the bashrc or profile file - depends on the system
if [ -f "$HOME/.bashrc" ]; then
    echo "export PATH=\$PATH:$(pwd)" >> ~/.bashrc
elif [ -f "$HOME/.profile" ]; then
    echo "export PATH=\$PATH:$(pwd)" >> ~/.profile
fi

# Installing pip
# Note: It should be "python3-pip" instead of "pip" on some systems
sudo apt install python3-pip

# Specify the absolute path to pip to ensure you're using the right one
pip_path=$(which pip)

# Installing Python libraries using the specified pip
libraries=("bcrypt" "geopy" "geocoder" "pillow")

for library in "${libraries[@]}"; do
    #$pip_path install "$library"
    # For Arch Linux, you can use the following command instead:
    sudo pacman -S python-"$library"
done

echo "Your pipboi is all set up."