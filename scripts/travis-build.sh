#!/bin/bash

set -e
set -o pipefail

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Launch using ansible
${SCRIPTDIR}/ansible-launch.sh
# Run infrastructure tests
# ...
# Destroy infrastructure
${SCRIPTDIR}/ansible-destroy.sh
