#!/bin/sh

function delete_file() {
    local file="$1"
    if [ -f "$file" ]; then
        debug "Removing file: $file"
        rm "$file"
    fi
}

function delete_folder() {
    local folder="$1"
    if [ -d "$folder" ]; then
        debug "Removing folder: $folder"
        rm -rf "$folder"
    fi
}

function copy_files() {
    local source_folder="$1"
    local destination_folder="$2"
    if [ ! -d "$destination_folder" ]; then
        debug "Creating folder: $destination_folder"
        mkdir -p "$destination_folder"
    fi
    debug "Copying files from $source_folder to $destination_folder"
    cp -a "$source_folder"/. "$destination_folder"
}

function prepend() {
    local file="$1"
    local text="$2"
    local tmpFile="$(mktemp)"
    echo "$text" >"$tmpFile"
    cat "$file" >>"$tmpFile"
    mv "$tmpFile" "$file"
}

function download() {
    local url="$1"
    local file="$2"
    if [ ! -f "$script" ]; then
        curl -sL "$url" -o "$file"
        chmod +x "$file"
    fi
}

function warn() {
    echo "\033[1;33m[ WARNING ] $1\033[0m"
}

function error() {
    echo "\033[1;31m[  ERROR  ] $1\033[0m"
}

function info() {
    echo "\033[1;34m[  INFO   ] $1\033[0m"
}

function success() {
    echo "\033[1;32m[ SUCCESS ] $1\033[0m"
}

function debug() {
    if [ -z $DEBUG]; then
        echo "\033[1;35m[  DEBUG  ] $1\033[0m"
    fi
}
