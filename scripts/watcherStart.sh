#!/bin/bash

# We need to wait for horizon to stream the ledgers
# echo "checking horizon..."
while ! curl $HORIZON_URL &> /dev/null ; do
  echo "Waiting for horizon to be available..."
  sleep 10
done

# Start the matheusbcomp/watcher image as usual (entrypoint)
# echo "starting from the image entrypoint..."
exec /root/start.sh
