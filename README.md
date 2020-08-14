# Delegated repo example

This repo is used by argo to deploy a demo of the idp application.

What argo will do is run `kustomize build .` at this top level, and
whatever yaml is there gets generated and deployed. 

Argocd will limit this deployment to the idp namespace, and also
only allow yaml to be pulled from this repo and the identity-eks repo.

This is meant to demonstrate how we would delegate the deployment of
the app to the engineers.

## idp config/secrets

These are currently all set with the `createconfig.sh` script.  Run it
for arguments.

## idp db setup

This currently doesn't work, but if you run `kubectl apply -f db-create.yaml`,
it should create the upaya database.  After that, deployments should
kick off the `db-migrate.yaml` job to do updates.

