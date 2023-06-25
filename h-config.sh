#!/usr/bin/env bash

cd `dirname $0`

[[ ! $CUSTOM_URL =~ tcp:// ]] && echo "Using default pool" && CUSTOM_URL="tcp://35.234.20.15:9999"

#CUSTOM_TEMPLATE="${CUSTOM_TEMPLATE%.*}"

conf=""
conf+="WAL=\"$CUSTOM_TEMPLATE\""$'\n'
conf+="HOST=\"$CUSTOM_URL\""$'\n'
conf+="PASS=\"$CUSTOM_PASS\""$'\n'
conf+="EXTRA=\"$CUSTOM_USER_CONFIG\""$'\n'

echo "$conf" > $CUSTOM_CONFIG_FILENAME
