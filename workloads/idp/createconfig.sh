#!/bin/sh
#
# XXX This should be done with the kustomization.yml stuff, but there
# seems to be no great way to get a real secret file in there where flux can see it.
#
# Probably should pull out of secrets bucket and apply.
#
# Also probably ought to patch instead of delete/recreate.  Or do a versioned thing.
# Or maybe deploy these with the app?
#

if [ ! -f "$1" ] && [ ! -f "$2" ] && [ ! -f "$3" ] && [ ! -f "$4" ] && [ ! -f "$5" ] && [ ! -f "$6" ] ; then
  echo "usage:    $0 <application.yml> <certs> <keys> <pwned_passwords.txt> <service_providers.yml>"
  echo "example:  $0 ../../../identity-idp/config/application.yml.default certs keys pwned_passwords.txt service_providers.yml"
  exit 1
fi

kubectl delete secret application.yml -n idp
kubectl create secret generic application.yml --from-file="$1" -n idp

kubectl delete secret agencies.yml -n idp
kubectl create secret generic agencies.yml --from-file="$2" -n idp

kubectl delete secret certs -n idp
kubectl create secret generic certs --from-file="$3" -n idp

kubectl delete secret keys -n idp
kubectl create secret generic keys --from-file="$4" -n idp

kubectl delete secret pwnedpasswords.txt -n idp
kubectl create secret generic pwnedpasswords.txt --from-file="$5" -n idp

kubectl delete secret serviceproviders.yml -n idp
kubectl create secret generic serviceproviders.yml --from-file="$6" -n idp
