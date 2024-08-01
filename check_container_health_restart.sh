#!/bin/bash

# Check if the container name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <container_name>"
  exit 1
fi

CONTAINER_NAME=$1

# Function to check the health status of the container
check_health_status() {
  local status=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME" 2>/dev/null)
  echo "$status"
}

# Function to restart the container
restart_container() {
  echo "Restarting container $CONTAINER_NAME..."
  docker restart "$CONTAINER_NAME"
}

# Get the health status of the container
health_status=$(check_health_status)

# Check if the container exists
if [ -z "$health_status" ]; then
  echo "Container $CONTAINER_NAME does not exist or does not have a health check."
  exit 1
fi

# Check if the container is healthy
if [ "$health_status" == "unhealthy" ]; then
  echo "Container $CONTAINER_NAME is not healthy. Status: $health_status"
  restart_container
else
  echo "Container $CONTAINER_NAME is healthy."
fi