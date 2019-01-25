Matt Farmer's Ghost Docker Image
================

This is a docker image that can be used to run a Ghost blog. I use it for my
personal blogs, and you're welcome to use it as well. Pull requests are welcome,
but ultimately I'm the primary consumer of this image so I won't accept things
that make my deployment super painful.

Deploying to Kubernetes
-------

I provide a helm chart that wraps this image if you'd like to deploy this
image to Kubernetes. To use it, you can add my Helm repository to your
helm CLI and install the chart.

```
helm repo add farmdawgnation https://github.frmr.me/helm-repository/
helm install farmdawgnation/ghost -f myvalues.yaml
```

You can take a look at the possible values you can set for the helm chart
in the [values.yaml][vals] file for the actual helm implementation.

[vals]: https://github.com/farmdawgnation/ghost-helm/blob/master/values.yaml

Deploying elsewhere
------

When deploying the image elsewhere you'll want to ensure you mount two things
into the container:

1. You'll want to mount a content volume at `/opt/ghost/content` inside the
  container. For new installations we recommend initializing the contents of
  your volume with the contents of `/opt/ghost/content` from within the image.
2. You'll want to mount your configuration file into `/opt/ghost`. If you run in
  production mode (with `NODE_ENV=production`) you'll want to mount this file
  as `/opt/ghost/config.production.json`. If you're not running in production
  mode then you'll want to mount it as `/opt/ghost/config.development.json`.
