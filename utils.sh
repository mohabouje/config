#!/bin/sh


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

function execute() {
    local command="$@"
    local output=$($command 2>&1)
    local status=$?
    debug "Executing: $command"
    if [ $status -ne 0 ]; then
        error "$output"
        error "Command '$command' failed with status $status"
        exit $status
    fi
}

function delete_file() {
    local file="$1"
    if [ -f "$file" ]; then
        debug "Removing file: $file"
        execute rm "$file"
    fi
}

function delete_folder() {
    local folder="$1"
    if [ -d "$folder" ]; then
        debug "Removing folder: $folder"
        execute rm -rf "$folder"
    fi
}

function copy_files() {
    local source_folder="$1"
    local destination_folder="$2"
    if [ ! -d "$destination_folder" ]; then
        debug "Creating folder: $destination_folder"
        execute mkdir -p "$destination_folder"
    fi
    debug "Copying files from $source_folder to $destination_folder"
    execute cp -a "$source_folder"/. "$destination_folder"
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
