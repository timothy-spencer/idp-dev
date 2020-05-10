#!/bin/sh
#
# XXX This should be done with the kustomization.yml stuff, but there
# seems to be no great way to get a real secret file in there where flux can see it.
#
# Also probably ought to patch instead of delete/recreate.
#

if [ ! -f "$1" ] ; then
  echo "usage:    $0 <database.yml>"
  echo "example:  $0 ../../../identity-idp/config/database.yml"
  exit 1
fi

kubectl delete secret database.yml
kubectl create secret generic database.yml --from-file="$1"

