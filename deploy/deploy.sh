#!/bin/bash

REPO_NAME="kj-test"

# Creating OCIR Repository
cd ..
cd infra
cd registry
terraform init 
terraform apply -auto-approve
cd ..
cd ..

cd app
cd $REPO_NAME

# Build the Docker image and capture the image ID
IMAGE_ID=$(docker build -q -t nodeslocal:v1.1 .)

# Tag the image with the desired repository and version
docker tag $IMAGE_ID iad.ocir.io/idmaqhrbiuyo/$REPO_NAME:v1.1

# Push the tagged image to the repository
docker push iad.ocir.io/idmaqhrbiuyo/$REPO_NAME:v1.1

echo "docker image pushed"
cd ..

echo "Provisioning resources- vcn,application,function,policy and invoke endpoint"
cd infra
cd functions
terraform init
terraform plan
terraform apply -auto-approve

echo "all done"