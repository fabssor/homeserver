#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

args=("$@")

###########
# Constants
# Indices for Argument access
COMMAND_ARGUMENT_INDEX=0

# List of supported commands
commands=(start-services stop-services clean-and-update-services)

# Indices for dictonary like access
START_SERVICES_INDEX=0
STOP_SERVICES_INDEX=1
CLEAN_AND_UPDATE_SERVICES_INDEX=2

# List of services shall match the name of folder in "services"
services=(heimdall portainer samba)

###############################
# Check commmand line arguments

if [[ ! " ${commands[*]} " =~ " ${args[${COMMAND_ARGUMENT_INDEX}]} " ]]; then
    echo "\"${args[0]}\" is not a supported command!"
fi


case ${args[${COMMAND_ARGUMENT_INDEX}]} in

  ${commands[${START_SERVICES_INDEX}]})
    for service in "${services[@]}"
    do
        cd services/$service
        docker compose up -d
        cd $SCRIPT_DIR
    done
    ;;

  ${commands[${STOP_SERVICES_INDEX}]})
    for service in "${services[@]}"
    do
        cd services/$service
        docker compose down
        cd $SCRIPT_DIR 
    done
    ;;

  ${commands[${CLEAN_AND_UPDATE_SERVICES_INDEX}]})
    echo "hello"
    for service in "${services[@]}"
    do
        cd services/$service
        docker compose down
        cd $SCRIPT_DIR 
    done
    docker system prune --all --volumes -f
    for service in "${services[@]}"
    do
        cd services/$service
        docker compose up --force-recreate --build -d
        cd $SCRIPT_DIR
    done
    ;;

    *)
    echo "default"
    ;;

esac

