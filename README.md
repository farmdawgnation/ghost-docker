Dockerized Ghost
================

This docker image contains Ghost 1.x.

You'll need to mount two volumes:

* The content directory will need to be mounted to /opt/ghost/content
* The config file will need to be mounted somewhere into /opt/ghost
  * For production: `config.production.json`
  * For development: `config.development.json`

The default command will run knex migrator to set up your database and then invoke `npm start`.
