#!/bin/bash

set -e
set -o pipefail

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Prepare ssh keys
${SCRIPTDIR}/prepare-env.sh
source ${SCRIPTDIR}/.shared-ssh-agent

# Launch the automation
cd ${SCRIPTDIR}/../terraform
${SCRIPTDIR}/../terraform plan
${SCRIPTDIR}/../terraform apply

