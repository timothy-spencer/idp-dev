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
  echo "usage:    $0 <application.yml> <certs> <keys> <pwned_passwords.txt> <service_providers.yml> <agencies.yml>"
  echo "example:  $0 ../../../identity-idp/config/application.yml.default certs keys pwned_passwords.txt service_providers.yml agencies.foo.yml"
  exit 1
fi

CONFIGDIR="/tmp/appconfig.$$/appconfig"
mkdir -p "$CONFIGDIR"

cp "$1" "$CONFIGDIR"/application.yml
cp -rp "$2" "$CONFIGDIR"/certs
cp -rp "$3" "$CONFIGDIR"/keys
cp "$4" "$CONFIGDIR"/pwned_passwords.txt
cp "$5" "$CONFIGDIR"/service_providers.yml
cp "$6" "$CONFIGDIR"/agencies.yml

kubectl create secret generic appconfig --from-file="$CONFIGDIR" -n idp --dry-run=client -o yaml | kubectl apply -f -

rm -rf "$CONFIGDIR"
rmdir /tmp/appconfig.$$
