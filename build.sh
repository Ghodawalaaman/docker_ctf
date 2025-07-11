#!/bin/bash

docker images remove test:latest
docker build -t test:latest .