#!/bin/bash

until [ "$answ" == "n" ]; do
    read -p "This start-up script will reboot your system at the end of PIPBOI initialization, proceed? [y|n] " answ
    if [ "$answ" == "y" ]; then
        echo "Starting PIPBOI start-up script..."
        break
    elif [ "$answ" == "n" ]; then
        echo "Stopping PIPBOI start-up."
        exit 0
    else
        echo "Incorrect argument, only [y|n]"
    fi
done

# Change the permission of the main system scripts and pipboi scripts to be executable
cd src
sudo chmod u+x passwd_funcs.py time_funcs.py network_funcs.py geo_funcs.py weather_funcs.py logger.py
sudo chmod u+x pipboi
cd ..

# Run unit tests
sudo chmod +x src/init.sh
bash src/init.sh

# Add the current directory to the PATH variable
export PATH=$PATH:$(pwd)/src

# Save the updated PATH variable to the bashrc or profile file - depends on the system
if [ -f "$HOME/.bashrc" ]; then
    echo "alias pipboi='bash $(pwd)/main.sh'" >> ~/.bashrc
    source ~/.bashrc
elif [ -f "$HOME/.profile" ]; then
    echo "alias pipboi=\"bash $(pwd)/main.sh\"">> ~/.profile
    source ~/.profile
elif [ -f "$HOME/.zshrc" ]; then
    echo "alias pipboi=\"bash $(pwd)/main.sh\"" >> ~/.zshrc
    source ~/.zshrc
fi

# Installing pip
# Note: It should be "python3-pip" instead of "pip" on some systems
sudo apt install python3-pip

#sudo python3 -m pip install --upgrade pip
sudo python3-pip install --upgrade pip

# Specify the absolute path to pip to ensure you're using the right one
pip_path=$(which pip)

# Installing Python libraries using the specified pip
libraries=("bcrypt" "geopy" "geocoder" "pillow" "pyserial")

echo "Starting installing libraries:"
echo
for library in "${libraries[@]}"; do
    $pip_path install "$library"
    # For Arch Linux, you can use the following command instead:
    #sudo pacman -S python-"$library"
done
echo

echo "Compiling Kilo text editor by Salvatore Sanfilippo."
echo
cd vendor
gcc -o kilo kilo.c
cd ..


echo "Your pipboi is all set up. The system will reboot in 60 sec."
sleep 60
sudo reboot now
