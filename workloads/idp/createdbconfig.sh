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

rm -f /tmp/rds-combined-ca-bundle.pem.$$
curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem > /tmp/rds-combined-ca-bundle.pem.$$
kubectl delete secret database.yml
kubectl create secret generic database.yml --from-file="$1"
kubectl create secret generic rds-combined-ca-bundle.pem --from-file=/tmp/rds-combined-ca-bundle.pem.$$
rm -f /tmp/rds-combined-ca-bundle.pem.$$
