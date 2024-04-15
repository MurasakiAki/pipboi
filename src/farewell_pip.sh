#!/bin/bash

farewells=("Bye" "Bye bye!" "Have a good day!" "See you soon!" "See ya!" "Come back soon!")
welcomes=("Hello!" "Hi!" "How it's going?" "Welcome, friend!" “Good Morning Starshine, the Earth Says Hello!” "Greetings!" "Welcome." "Glad to see you again." "How've you been?" "Hi, it's great to have you here!" "Hey, welcome!" "Hey!" "Heya!")

function tell_farewell() {
    array_length=${#farewells[@]}
    random_index=$((RANDOM % array_length))

    echo "${farewells[$random_index]}"
}

function tell_welcome() {
    array_length=${#welcomes[@]}
    random_index=$((RANDOM % array_length))

    echo "${welcomes[$random_index]}"
}