#!/usr/bin/env bash

# The script will create an ACI containing iOzone (http://www.iozone.org/) and important metadata.

set -e

if [ "$EUID" -ne 0 ]; then
    echo "This script uses functionality which requires root privileges"
    exit 1
fi

# A non-installed acbuild can be used, for example:
# ACBUILD=../../appc/acbuild/bin/acbuild
ACBUILD=${ACBUILD:-acbuild}

if ! command -v $ACBUILD >/dev/null; then
    echo "acbuild ($ACBUILD) is not executable"
    exit 1
fi

# Start the build with an empty ACI
acbuild --debug begin

# In the event of the script exiting, end the build
acbuildEnd() {
    export EXIT=$?
    acbuild --debug end && exit $EXIT 
}

# When the script exits, remove the binary we built
trap acbuildEnd EXIT

# Name the ACI
acbuild --debug set-name ivanc/iozone-ubuntus

# Based on ubuntu
acbuild --debug dep add quay.io/sameersbn/ubuntu

# Copy start script 
acbuild copy run-iozone.sh /run-iozone.sh

# Update ubuntu
acbuild --debug run -- apt-get update

# Download and build iozone
acbuild --debug run -- apt-get -y install make gcc build-essential

acbuild --debug run -- wget  http://iozone.org/src/current/"$(curl http://iozone.org/ | grep 'Latest tarball' | cut -c 23-37)"
acbuild --debug run -- tar xvf iozone*.tar && rm iozone*.tar
acbuild --debug run -- make -C "$(curl http://iozone.org/ | grep 'Latest tarball' | cut -c 23-33)"/src/current linux
acbuild --debug run -- cp "$(curl http://iozone.org/ | grep 'Latest tarball' | cut -c 23-33
)"/src/current/iozone /usr/bin

# Cleaning
acbuild --debug run -- apt-get -y --purge remove make gcc build-essential

acbuild --debug set-exec -- /run-iozone.sh 

# Save the ACI
acbuild --debug label add version 0.1.0
acbuild --debug label add arch amd64
acbuild --debug label add os linux
acbuild --debug annotation add authors "Ivan"

acbuild --debug write --overwrite iozone-ubuntu.aci
