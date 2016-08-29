#!/bin/bash

set -e
set -o pipefail

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Prepare ssh keys
${SCRIPTDIR}/prepare-env.sh
source .shared-ssh-agent

# Launch the automation
cd ${SCRIPTDIR}/../ansible
ansible-playbook launch.yml -vv

