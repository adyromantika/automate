#!/bin/bash

set -e
set -o pipefail

TERRAFORM_VERSION="0.7.2"

# Make sure that this script can be run from any directory
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "${LAUNCHER}" == "ansible" ]; then
    pip install ansible boto
    # Launch using ansible
    #${SCRIPTDIR}/ansible-launch.sh
    # Run infrastructure tests
    # ...
    # Destroy infrastructure
    #${SCRIPTDIR}/ansible-destroy.sh
else
    cd ${SCRIPTDIR}
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
    # Launch using terraform
    ${SCRIPTDIR}/terraform-launch.sh
    # Run infrastructure tests
    # ...
    # Destroy infrastructure
    ${SCRIPTDIR}/terraform-destroy.sh
fi
