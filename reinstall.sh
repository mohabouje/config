#!/bin/sh

ROOT_DIRECTORY=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
sh ${ROOT_DIRECTORY}/clean.sh
sh ${ROOT_DIRECTORY}/install.sh
sh ${ROOT_DIRECTORY}/configure.sh