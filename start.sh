#! /usr/bin/bash

White="\033[1;37m"
Red="\033[1;31m"
Reset="\033[0m"


# Message handler functions 
function prs() {
    echo -e "$White ==> $1 $Reset"
}

function error() {
    echo -e "$Red Unhandled argument: $1 $Reset"
}

function checkDepends() {
    is_uvicorn=$(command -v uvicorn &> /dev/null)
    if ! $is_uvicorn ; then
        echo "${Red}Uvicorn is not installed 😥 $Reset"
        exit
    fi
}

function startServer() {
    if [ "$1" == dev ] ; then
        uvicorn api.main:app --reload
    else
        uvicorn api.main:app
    fi
}

function main() {
    clear

    if [ "$1" == dev ] ; then
        echo -e "$White Nexa-APIs 🌊 - Dev Mode (v0.2.5) $Reset\n\n "
        case "$2" in
            -u|--update)
                pip3 install -U -r requirements.txt; shift ;;
            "")
                shift ;;
        *)
            error "$2"
        esac
    else
        echo -e "$White Nexa-APIs 🌊 - v0.2.5 $Reset\n\n "
    fi

    prs "Checking Dependencies 🔎..."
    checkDepends
    prs "All done ✅"
    prs "Starting the server 📡..."
    startServer "$1"
}

main "$1" "$2"