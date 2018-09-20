#!/bin/bash
export FABRIC_START_TIMEOUT=15

# Exit on first error, print all commands.
set -ev

#Detect architecture
ARCH=`uname -m`

# Grab the current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#

# ARCH=$ARCH docker-compose -f "${DIR}"/composer/docker-compose-peer2.yml down
ARCH=$ARCH docker-compose -f "${DIR}"/composer/docker-compose-kafka1.yml up -d

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}