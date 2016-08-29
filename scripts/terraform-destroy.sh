#!/bin/bash

set -e
set -o pipefail

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Launch the automation
cd ${SCRIPTDIR}/../terraform
${SCRIPTDIR}/terraform destroy -force

