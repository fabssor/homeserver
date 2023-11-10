#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

args=("$@")

###########
# Constants
# Indices for Argument access
COMMAND_ARGUMENT_INDEX=0
SERVICE_ARGUMENT_INDEX=1

# List of supported commands
commands=(start-service stop-service restart-service clean-and-update-service)

# Indices for dictonary like access
START_SERVICES_INDEX=0
STOP_SERVICES_INDEX=1
RESTART_SERVICES_INDEX=2
CLEAN_AND_UPDATE_SERVICES_INDEX=3

# List of services shall match the name of folder in "services"
services=(heimdall portainer samba homeassistant)

###############################
# Check if a service was provided or all.
# if the argument is empty we will override to "all" as default

if [[ "  " = " ${args[${SERVICE_ARGUMENT_INDEX}]} " ]]; then
    args[${SERVICE_ARGUMENT_INDEX}]="all"
fi

if [[ ! " ${services[*]} " =~ " ${args[${SERVICE_ARGUMENT_INDEX}]} " ]]; then
    if [[ ! " all " =~ " ${args[${SERVICE_ARGUMENT_INDEX}]} " ]]; then
        echo "\"${args[${SERVICE_ARGUMENT_INDEX}]}\" is not a service!"
        exit -127
    fi
fi

# we will only come here if the argument is valid so we can directly assign it here
if [[ " all " = " ${args[${SERVICE_ARGUMENT_INDEX}]} " ]]; then
    services_to_execute=("${services[@]}")
else
    services_to_execute=${args[${SERVICE_ARGUMENT_INDEX}]}
fi

###############################
# Check commmand line arguments

if [[ ! " ${commands[*]} " =~ " ${args[${COMMAND_ARGUMENT_INDEX}]} " ]]; then
    echo "\"${args[${COMMAND_ARGUMENT_INDEX}]}\" is not a supported command!"
    exit -127
fi


case ${args[${COMMAND_ARGUMENT_INDEX}]} in

  ${commands[${START_SERVICES_INDEX}]})
    for service in "${services_to_execute[@]}"
    do
        cd services/$service
        docker compose up -d
        cd $SCRIPT_DIR
    done
    ;;

  ${commands[${STOP_SERVICES_INDEX}]})
    for service in "${services_to_execute[@]}"
    do
        cd services/$service
        docker compose down
        cd $SCRIPT_DIR 
    done
    ;;
    
  ${commands[${RESTART_SERVICES_INDEX}]})
    for service in "${services_to_execute[@]}"
    do
        cd services/$service
        docker compose restart
        cd $SCRIPT_DIR 
    done
    ;;

  ${commands[${CLEAN_AND_UPDATE_SERVICES_INDEX}]})
    echo "hello"
    for service in "${services_to_execute[@]}"
    do
        cd services/$service
        docker compose down
        cd $SCRIPT_DIR 
    done
    docker system prune --all --volumes -f
    for service in "${services_to_execute[@]}"
    do
        cd services/$service
        docker compose up --force-recreate --build -d
        cd $SCRIPT_DIR
    done
    ;;

    *)
    echo "Open gates to hell..."
    ;;

esac

