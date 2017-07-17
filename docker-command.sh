#!/bin/bash

if [[ ! -d "content/themes" ]]; then
  cp -R content-default/themes content/themes
fi

if [[ ! -d "content/logs" ]]; then
  mkdir content/logs
fi

if [[ ! -d "content/adapters" ]]; then
  mkdir content/adapters
fi

if [[ ! -d "content/apps" ]]; then
  mkdir content/apps
fi

if [[ ! -d "content/data" ]]; then
  mkdir content/data
fi

if [[ ! -d "content/images" ]]; then
  mkdir content/images
fi

node_modules/.bin/knex-migrator migrate --init

npm start
