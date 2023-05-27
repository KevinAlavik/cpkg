#!/bin/bash
# CPKG Source Code

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
    packageFile="cpkg-pack.json"
    curl -s "$source" -o "$packageFile"

    if [ ! -s "$packageFile" ]; then
        echo "Failed to download the package file: $packageFile"
        exit 1
    fi

    headerDir=$(jq -r '.headerDir' "$packageFile")
    if [ -z "$headerDir" ]; then
        echo "Error: headerDir value not found or is null in cpkg-pack.json. Invalid Package"
        exit 1
    else
        echo "headerDir: $headerDir"
    fi

    libSource="${source/cpkg-pack.json/$headerDir}"
    echo "libSource: $libSource"

    # Fetch each .h file and save it
    headerFiles=$(jq -r '.headerFiles[]' "$packageFile")
    if [ -z "$headerFiles" ]; then
        echo "No header files found in cpkg-pack.json."
    else
        while IFS= read -r hFile; do
            echo "Downloading $hFile"
            curl -s "$libSource$hFile" -o "$hFile"
        done <<< "$headerFiles"
    fi

    echo "Package installation complete."
    
    rm "$packageFile"
}

function show_help {
    echo "Usage: cpkg install <packageName> [-o <outputDirectory>]"
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
    cd ..
    rm source.json
elif [ "$1" == "--help" ]; then
    show_help
elif [ "$1" == "run" ]; then
    sudo 
    if [ -z "$2" ]; then
        echo "C file path not provided."
        exit 1
    fi

    gcc $2 -o tmp/cpkg-compiled
    sudo bash tmp/cpkg-compiled
    sudo rm -rf tmp/cpkg-compiled
else
    echo "Invalid command."
    show_help
    exit 1
fi
