#!/bin/bash

farewells=("Bye" "Bye bye!" "Have a good day!" "See you soon!" "See ya!" "Come back soon!")

function tell_farewell() {
    array_length=${#farewells[@]}
    random_index=$((RANDOM % array_length))

    echo "${farewells[$random_index]}"
}