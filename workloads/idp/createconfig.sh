#!/bin/sh
#
# XXX This should be done with the kustomization.yml stuff, but there
# seems to be no great way to get a real secret file in there where flux can see it.
#
# Also probably ought to patch instead of delete/recreate.
#

if [ ! -f "$1" ] ; then
  echo "usage:    $0 <application.yml>"
  echo "example:  $0 ../../../identity-idp/config/application.yml.default"
  exit 1
fi

kubectl delete secret application.yml
kubectl create secret generic application.yml --from-file="$1"

