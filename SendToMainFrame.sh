#!/bin/bash

################################################################################
#
# Filename: SendToMainFrame.sh
#
# Purpose: Use sshpass and sftp to transfer a file from the ESB servers to the
# Mainframe, clemson.clemson.edu.
#
# DATE          AUTHOR                  CHANGES
#
# 20131210      Charles H. Baker        Created.
#
################################################################################


DEBUG='false'


debug () {
    if [ $DEBUG == "true" ]
    then
        echo $1
    fi
}


usage () {

    echo "$0 FILENAME"
    echo "If no filename is supplied will be set to FAMRECIP"
    echo "$0 requires /usr/bin/sshpass and /usr/bin/sftp"

}


# Perhaps this should be pulled in from a separate file?
export SSHPASS=""

# sshpass must be installed on the ESB boxes
COMMAND='/usr/bin/sshpass -e /usr/bin/sftp -oPort=2222 CURAMESB@clemson.clemson.edu'


# If no file name is passed in default file name is FAMRECIP
if [ -z $1 ]
then    
    usage
    FILE='FAMRECIP'
else
    FILE=$1
fi


debug $FILE


$COMMAND << EOF
cd //MEDS/CURAM
ls /+mode=binary
ls /+recfm=vb,lrecl=1028,blksize=27998
ls /+linerule=flexible
put $FILE
bye
EOF

