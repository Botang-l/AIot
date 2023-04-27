#!/bin/bash

cd $(dirname "$0")

# setup environment variables
ROOT="$PWD"
source "$ROOT/env_setup.sh"

[ ! -d "./projects" ] && mkdir "projects"

# run the docker container
echo "docker folder: $ROOT"
cd "$ROOT"
cp env_setup.sh Docker/

bash run-docker.sh
