#!/usr/bin/env bash

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
trap acbuildEnd EXIT

# Name the ACI
acbuild --debug set-name example.com/iozone

# Based on ubuntu
acbuild --debug dep add quay.io/sameersbn/ubuntu

# Install iozone
acbuild --debug run -- apt-get update
acbuild --debug run -- apt-get -y install make gcc build-essential
acbuild --debug run -- wget http://www.iozone.org/src/current/iozone3_434.tar
acbuild --debug run -- tar xvf iozone3_434.tar
acbuild --debug run -- make -C iozone3_434/src/current linux
acbuild --debug run -- cp iozone3_434/src/current/iozone /usr/bin

# Add a mount point for files to serve
acbuild --debug mount add results /tmp/

# Run iozone 
## https://communities.bmc.com/docs/DOC-10204
# -a         full automatic mode
# -R         excel compatible text output
# -l and -u  lower and upper limit on threads/processes 
# -r         the record size
# -s         the size of the file that needs to be tested
# -F         the temporary filename that should be used by the iozone during testing

acbuild --debug set-exec -- /usr/bin/iozone -R -l 5 -u 5 -r 4k -s 100m -F /home/f1 /home/f2 /home/f3 /home/f4 /home/f5 | tee -a /tmp/results.txt &

# Save the ACI
acbuild --debug label add version 0.0.1
acbuild --debug label add arch amd64
acbuild --debug label add os linux
acbuild --debug annotation add authors "Ivan"

acbuild --debug write --overwrite iozone-latest-linux-amd64.aci