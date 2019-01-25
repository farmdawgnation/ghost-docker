#!/bin/bash

set -e

#####
# Install extra storage modules
#
# Storage modules can be specified in the environment variable STORAGE_MODULES
# in a comma separated list of npm modules to install and copy into the
# storage directory for use.
#
# You must also turn the module on in your config for it to take effect.
#####
if [ ! -d "content/storage" ]; then
  mkdir content/storage
fi

IFS=',' read -r -a storages <<< "$STORAGE_MODULES"
for storage in "${storages[@]}"; do
  echo "Installing $storage"
  npm install $storage
  cp -r node_modules/$storage content/storage/
done

# Start ghost
npm start
