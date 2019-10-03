#!/bin/bash

#Export Image-ID name for CD Build Job
IMAGE_NAME=$1
export GIT_COMMIT_SHORT="$(echo $GIT_COMMIT | cut -c 1-7)"
export RELEASE_VERSION=$(xmllint --xpath "//*[local-name()='project']/*[local-name()='version']/text()" pom.xml)
export IMAGE_ID="$IMAGE_NAME":"$GIT_COMMIT_SHORT-build${BUILD_NUMBER}"
#echo "RELEASE_VERSION " ${RELEASE_VERSION}
#Creating image-id.txt file for Trigger Parameterized to pass env to next CD Build Job


echo IMAGE_ID=$IMAGE_ID > /tmp/image-id.txt

#####################################################

#Creating Jenkins Env variable to USE in Tagging

export GIT_REVISION=`echo ${GIT_COMMIT} | cut -c 1-7`

echo IMAGE_TAG="${GIT_REVISION}-build${BUILD_NUMBER}" > /tmp/jenkins-tag-id.txt

chmod 777 /tmp/jenkins-tag-id.txt
