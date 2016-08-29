#!/bin/bash

set -e
set -o pipefail

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# SSH key file
SSH_KEY_FILENAME=automate.pem
SSH_KEY=${SCRIPTDIR}/../${SSH_KEY_FILENAME}

if [ ! -f ${SSH_KEY} ]; then
    echo "Error: The file ${SSH_KEY} can't be found"
    exit 1
else
    chmod 600 ${SSH_KEY}
fi

if [ -z ${AWS_ACCESS_KEY_ID} ] || [ -z ${AWS_SECRET_ACCESS_KEY} ]; then
    echo "Error: Both AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variables are required"
    exit 1
fi

# Make sure ssh-agent is alive
if [ -f ".shared-ssh-agent" ]; then
    source ".shared-ssh-agent"
else
    eval "$(ssh-agent -s > .shared-ssh-agent)"
fi

# Load identity into agent
ssh-add ${SSH_KEY}
ssh-add -l

