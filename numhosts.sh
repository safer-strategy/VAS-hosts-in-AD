#!/bin/bash

# Determine the number of VAS enabled users and hosts are in AD
# Note this will include systems that have been decommissioned without unjoining
NUMUSERS=`/opt/quest/bin/vastool -u host/ \
	search -q "(&(uidNumber=*)(gidNumber=*)(unixHomeDirectory=*)(loginShell=*))" distinguishedName \
	| wc -l`
NUMSYS=`/opt/quest/bin/vastool -u host/ \
	search -q '(&(objectCategory=Computer)(!(operatingSystem=Windows*)))' name \
	| wc -l`

echo "Number of QAS Enabled Users:         $NUMUSERS"
echo "Number of QAS Installed Unix Hosts:  $NUMSYS"
