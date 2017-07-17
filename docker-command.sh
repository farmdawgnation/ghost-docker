#!/bin/bash

if [ ! -d "content/themes" ]; then
  cp -R content-default/themes content/themes
fi

if [ ! -d "content/logs" ]; then
  mkdir content/logs
fi

if [ ! -d "content/adapters" ]; then
  mkdir content/adapters
fi

if [ ! -d "content/apps" ]; then
  mkdir content/apps
fi

if [ ! -d "content/data" ]; then
  mkdir content/data
fi

if [ ! -d "content/images" ]; then
  mkdir content/images
fi

# Init is idempotent. It will only create tables if they don't already
# exist.
node_modules/.bin/knex-migrator init

# Migrate the database if needed.
node_modules/.bin/knex-migrator migrate

# Start ghost
npm start
