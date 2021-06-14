#!/bin/sh

address="$1"

if [ -z $address ]; then
  echo 'address is required'
  exit 1
fi
echo "health check to $address"

result=$(curl -Is $address | head -n 1)

if [ -z "$result" ]; then
  echo "this address $address isn't working"
  exit 1
fi

echo "this address $address is working"
exit 0
