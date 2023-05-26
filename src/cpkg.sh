#!/bin/bash

packageSource="https://puffer.is-a.dev/cpkg/source.json"

function fetch_package_source {
    echo "Fetching package source: $packageSource"
    curl -s "$packageSource" -o source.json
}

function get_source_for_package {
    packageName=$1

    source=$(jq -r --arg pkg "$packageName" '.packages[] | select(.name == $pkg) | .source' source.json)
    if [ -z "$source" ]; then
        echo "Package '$packageName' not found in the package source."
        exit 1
    fi

    echo "$source"
}

function install_package {
    packageName=$1
    outputDirectory=$2
    source=$3

    echo "Installing package: $packageName"

    if [ -z "$outputDirectory" ]; then
        echo "Output directory not specified. Installing in the current directory."
        outputDirectory="."
    else
        echo "Installing in directory: $outputDirectory"
        mkdir -p "$outputDirectory"
        cd "$outputDirectory" || exit
    fi

    # Download the source file using curl
    curl -s "$source" -o package.cpkg

    # Get the headerDir value from package.cpkg
    headerDir=$(jq -r '.headerDir' package.cpkg)
    if [ -z "$headerDir" ]; then
        echo "Error: headerDir value not found in the package source file. Invalid Package"
        exit 1
    fi

    # Replace the filename with the headerDir value in the source URL
    source="${source%/*}/$headerDir"

    # Download the updated source file using curl
    curl -s "$source" -o package.cpkg

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

    fetch_package_source

    source=$(get_source_for_package "$packageName")

    if [ -z "$source" ]; then
        echo "Package '$packageName' not found in the package source."
        exit 1
    fi

    install_package "$packageName" "$outputDirectory" "$source"
elif [ "$1" == "--help" ]; then
    show_help
else
    echo "Invalid command."
    show_help
    exit 1
fi
