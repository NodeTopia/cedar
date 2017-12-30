#!/bin/bash
set -m

PROC_TYPE=$1
BUILD_URL=$2

wget $BUILD_URL -O /tmp/app.tar  2> /dev/null
tar -xf /tmp/app.tar -C /  2> /dev/null
chown -R herokuishuser /app 2> /dev/null

/start $PROC_TYPE
