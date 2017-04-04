NUMUSERS=`/opt/quest/bin/vastool -u host/ search -q "(&(uidNumber=*)(gidNumber=*)(unixHomeDirectory=*)(loginShell=*))" distinguishedName| wc -l`
NUMSYS=`/opt/quest/bin/vastool -u host/ search -q '(&(objectCategory=Computer)(!(operatingSystem=Windows*)))' name | wc -l`

echo "Number of QAS Enabled Users:         $NUMUSERS"
echo "Number of QAS Installed Unix Hosts:  $NUMSYS"
