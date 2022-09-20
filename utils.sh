#!/bin/sh

TERMINAL_COLOR_BLACK=30
TERMINAL_COLOR_RED=31
TERMINAL_COLOR_GREEN=32
TERMINAL_COLOR_YELLOW=33
TERMINAL_COLOR_BLUE=34
TERMINAL_COLOR_MAGENTA=35
TERMINAL_COLOR_CYAN=36
TERMINAL_COLOR_WHITE=37
TERMINAL_COLOR_GRAY=90

function colored() {
    echo "\033[1;${2}m${1}\033[0m"
}

function __yes() {
    colored "✓ Yes" $TERMINAL_COLOR_GREEN
}

function __no() {
    colored "✗ No" $TERMINAL_COLOR_RED
}

function __success() {
    colored "✓ Success" $TERMINAL_COLOR_GREEN
}

function __failed() {
    colored "✗ Failed" $TERMINAL_COLOR_RED
}

function info() {
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo "${NOW} $(colored "$1" $TERMINAL_COLOR_BLUE)"
}

function warning() {
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo "${NOW} $(colored "$1" $TERMINAL_COLOR_YELLOW)"
}

function error() {
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo "${NOW}  $(colored "✗ Failed $1" $TERMINAL_COLOR_RED)"
}

function success() {
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo "${NOW}  $(colored "✓ Success $1" $TERMINAL_COLOR_GREEN)"
}

function debug() {
    if [ -n "${DEBUG+set}" ]; then
        NOW=$(date +"%Y-%m-%d %H:%M:%S")
        echo "${NOW} $(colored "$1" $TERMINAL_COLOR_GRAY)"
    fi
}

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

function prepend_ln() {
    local file="$1"
    local text="$2"
    local tmpFile="$(mktemp)"
    echo "" >>"$tmpFile"
    echo "$text" >"$tmpFile"
    cat "$file" >>"$tmpFile"
    mv "$tmpFile" "$file"
}

function prepend() {
    local file="$1"
    local text="$2"
    local tmpFile="$(mktemp)"
    echo "$text" >"$tmpFile"
    cat "$file" >>"$tmpFile"
    mv "$tmpFile" "$file"
}

function append() {
    local file="$1"
    local text="$2"
    echo "$text" >>"$file"
}

function append_ln() {
    local file="$1"
    local text="$2"
    echo "" >>"$file"
    echo "$text" >>"$file"
}

function is_command_exists () {
    type "$1" &> /dev/null ;
}