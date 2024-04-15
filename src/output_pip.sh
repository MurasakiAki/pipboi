#!/bin/bash

emotions=("'V'" ">v<" "◠‿◠" "¬‿¬✿" "◕ω◕✿" "｡♥‿♥｡" "☉_☉" "'o'" "⊙△⊙" "<_<" "¬_¬" "⌣_⌣”" "QvQ" "ಥ﹏ಥ" "╥﹏╥" "╬ Ò﹏Ó" "=_=" "⋋▂⋌")

# normal 0-2
# love 3-5
# surprise 6-8
# disappointment 9-11
# sad 12-14
# angry 15-17

function output() {
    local emotion="$1"

    case $emotion in
        "random")
            array_length=${#emotions[@]}
            random_index=$((RANDOM % array_length))
            emotion="${emotions[$random_index]}"
            ;;
        "normal")
            start_index=0
            end_index=2
            ;;
        "love")
            start_index=3
            end_index=5
            ;;
        "surprise")
            start_index=6
            end_index=8
            ;;
        "disappointment")
            start_index=9
            end_index=11
            ;;
        "sad")
            start_index=12
            end_index=14
            ;;
        "angry")
            start_index=15
            end_index=17
            ;;
        *)
            echo "Invalid emotion: $emotion"
            return 1
            ;;
    esac

    if [ "$start_index" -ge 0 ] && [ "$end_index" -lt ${#emotions[@]} ] && [ "$start_index" -le "$end_index" ]; then
        random_index=$((RANDOM % ($end_index - $start_index + 1) + $start_index))
        emotion="${emotions[$random_index]}"
    else
        echo "Invalid range of indexes for emotion: $emotion"
        return 1
    fi

    #clear
    echo "===================================================="
    echo "                       ,~."
    echo "                      ($emotion)"
    echo "                     //-=-\\\\"
    echo "                     (\_=_/)"
    echo "                      ^^ ^^"
    echo "===================================================="
    emotion=""
}