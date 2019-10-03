#!/bin/bash

# Example for the Docker Hub V2 API
# Returns all images and tags associated with a Docker Hub organization account.
# Requires 'jq': https://stedolan.github.io/jq/


REPO_NAME=$1

# -------

set -e
#echo

# get token
#echo "Retrieving token ..."
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'$

#echo
#echo "Images and tags for Development Solution-Backend in organization: ${ORG}"
#echo

IMAGE_TAGS=$(curl -s -H "Authorization: JWT ${TOKEN}" https://hub.docker.com/v2$
echo ${IMAGE_TAGS}
