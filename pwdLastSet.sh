#!/bin/bash
#set -x

# Find Computers that have not checked in in 120 days
# PasswordPolicy="120"
PasswordPolicy="120"

Test () {
#: '  # Commented Out
     echo "Hostname: $host"
     echo "Todays Date: $todayDate"
     echo "pwdLastSet Date: $lastUnix"
     echo "Today - Last: $diffUnix"
     echo "Days from Last Change:: $diffdays"
     echo "Remaining: $daysremaining"
     echo "Expired days: $daysexpired"
#'
}

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

todayDate=`date "+%s"`
echo ""

for host in `
  # Extract a list of non-windows Computer accounts
  /opt/quest/bin/vastool -u host/ search '(&(objectclass=computer)(!(operatingSystem=Windows*)))' dn \
  | awk -F = '{print $2}'| awk -F , '{print $1}'`
  do
    # Locate the time the computer account changed
    pwdLastSet=`/opt/quest/bin/vastool -u host/ search "(&(objectclass=computer)(sAMAccountName=${host}*))" pwdLastSet \
    | grep pwdLastSet | awk '{print $2}'`
    # Convert value to pwdLastSet to Unix
    lastUnix=$((( $pwdLastSet / 10000000 - 11644473600 )))
    # Process dates for policy
    diffUnix=$((( $todayDate - $lastUnix )))
    diffdays=$((( $diffUnix / 86400 )))
    daysexpired=$((( $diffdays - $PasswordPolicy )))
    daysremaining=$((( $PasswordPolicy - $diffdays )))

    : '
    Test # Uncomment to run Test function
    '

    if [[ "$PasswordPolicy" -gt "$diffdays"  ]]
      then
        # Host has a valid Computer password.
        # echo "$host Password valid: $daysremaining"
        # echo ""
        continue
      else
          # Host has expired Computer account password
          echo "$host invalid: Password expired  $daysexpired"
          echo ""
        continue
    fi
  done
