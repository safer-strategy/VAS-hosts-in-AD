#!/bin/bash

# Determine the number of VAS enabled users and hosts are in AD
# Note this will include systems that have been decommissioned without unjoining

# Test for root
  if [[ $UID -ne 0 ]]; then
    echo "$0 must be run as root"
    exit 1
  fi

NUMUSERS=`/opt/quest/bin/vastool -u host/ \
  search -q "(&(uidNumber=*)(gidNumber=*)(unixHomeDirectory=*)(loginShell=*))" distinguishedName \
  | wc -l`
NUMSYS=`/opt/quest/bin/vastool -u host/ \
  search -q '(&(objectCategory=Computer)(!(operatingSystem=Windows*)))' name \
  | wc -l`
NUMVAS=`/opt/quest/bin/vastool -u host/ \
  search -q '(&(objectCategory=Computer)(!(operatingSystem=Windows*)))' name operatingSystemVersion \
  | grep -E "QAS|VAS" | wc -l`

echo "Number of QAS Enabled Users:  $NUMUSERS"
echo "Number of Non-Windows Hosts:  $NUMSYS"
echo "Number of QAS/VAS Hosts:      $NUMVAS"
