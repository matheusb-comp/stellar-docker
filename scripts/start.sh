#!/bin/bash

# Get the secret in /run/secrets and export its contents as env variables
if [ -n $1 ]; then
  # -o allexport (-a): Mark variables which are modified or created for export
  # Using + rather than - causes these flags to be turned off.
  set -o allexport
  source /run/secrets/$1
  set +o allexport
  # Throw away the secret name, but keep all the other arguments
  shift
fi

# TODO: Remove this and run the code on a proper docker image in the stack
if [ ! -f /opt/stellar/getvoters ]; then
  wget https://github.com/matheusb-comp/go/releases/download/v0.1/getvoters
  chmod +x getvoters
  mv getvoters /opt/stellar/getvoters
fi
/opt/stellar/getvoters -pass $POSTGRES_PASSWORD &

# Start the stellar/quickstart image as usual (entrypoint)
/init -- /start $@
