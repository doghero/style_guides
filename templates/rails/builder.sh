#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "Type your project name? \n${YELLOW}(in lowercase and seppareted with underscores)${NC}"
read APP_NAME
echo APP_NAME=$APP_NAME > .env

echo -e "${GREEN}Building enviroment to setup rails...${NC}"
docker-compose build

echo -e "${GREEN}Starting the builder...${NC}"

docker-compose run --rm generator \
    rails new builded/$APP_NAME \
    --api --skip-sprockets \
    --skip-javascript \
    --skip-turbolinks \
    --skip-test-unit \
    --database postgresql \
    -m templates/template.rb

sudo chown -R $USER builded
