#!/bin/bash

packageSource = https://puffer.is-a.dev/cpkg/source.json

function install_package {
    packageName=$1
    outputDirectory=$2

    echo "Installing package: $packageName"
    
    if [ -z "$outputDirectory" ]; then
        echo "Output directory not specified. Installing in current directory."
    else
        echo "Installing in directory: $outputDirectory"
        mkdir -p "$outputDirectory"
        cd "$outputDirectory" || exit
    fi

    

    echo "Package installation complete."
}

function show_help {
    echo "Usage: cpkg install <packageName> [-o <outPutDirectory>]"
}

if [ "$1" == "install" ]; then
    if [ -z "$2" ]; then
        echo "Package name not provided."
        exit 1
    fi

    packageName=$2
    outputDirectory=""

    if [ "$3" == "-o" ]; then
        if [ -z "$4" ]; then
            echo "Output directory not provided."
            exit 1
        fi
        outputDirectory=$4
    fi

    install_package "$packageName" "$outputDirectory"
elif [ "$1" == "--help" ]; then
    show_help
else
    echo "Invalid command."
    show_help
    exit 1
fi
