#!/bin/bash

#Simple script for checking directories on remote host


#Parsing the sshconfig file
HOSTNAMES=`cat .ssh/config |grep -w Host |cut -d " " -f2`

#Test variable for single host - simply swap inside the for loop to check only one host
HOSTNAME=google.com

#Adding locations as multiline string (below are just examples, add yours to suit your usecase )
LOCATIONS="
/cloudera
/var/lib/cloudera-scm-server
/etc/hosts
/var/log
/etc/passwd
/opt/cloudera/security
"

#main function utilizing nested for loops along with if statements
hostLoop () {

for i in $HOSTNAMES ; do
echo "Hostname: $i"

	for j in $LOCATIONS ; do

	#command variable - in this case we are checking files modified within 30 days
	output=$(ssh $i "find $j -type f -mtime -30 -exec ls -latr {} \; 2> /dev/null |tail -2")
		if [[ -n $output ]] ; then
		echo $j && echo "$output"
		fi
	done

done

}

hostLoop
