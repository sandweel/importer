#!/bin/bash

tmpKeyName="aws_insecure_key"
HOST="$2"
PORT="$3"

red()
{
    printf "\e[31m"
}
green()
{
    printf "\e[32m"
}
regular()
{
    printf "\e[m"
}

selfUpdate() {
    SCRIPT=$(readlink -f "$0")
    SCRIPTPATH=$(dirname "$SCRIPT")
    SCRIPTNAME="importer.sh"
    BRANCH="master"

    cd $SCRIPTPATH
    git fetch &>/dev/null

    if [[ -n `git diff --name-only origin/$BRANCH | grep $SCRIPTNAME` ]];then
        echo "Found a new version of me, updating myself..."
        git pull --force &>/dev/null && \
        echo "$(green)Updated. Re-run script again!($regular)" || \
        echo "$(red)Not updated. Try to clone it manually: 'git clone git@bitbucket.org:absolutewebservices/importer.git'($regular)"
        exit 1
    fi
}

selfUpdate

getStatus() {
    if [[ $? != 0 ]];then
        echo "$(red)$@ failed!$(regular)"
        exit 1
    else
        echo "$(green)$@ finished successfully!$(regular)"
    fi
}
sshKeygen() {
    if [[ -z $PORT ]];then
        PORT="22"
    fi

    if [[ -z $HOST ]];then
        echo "$(red)Hostname or ip address is missing$(regular)"
        exit 1
    fi
    read -p "Enter login: " USER
    rm -f /tmp/$tmpKeyName*
    ssh-keygen -b 2048 -t rsa -f /tmp/$tmpKeyName -q -N "" -C "$tmpKeyName" &>/dev/null
    ssh-copy-id -i /tmp/$tmpKeyName.pub $USER@$HOST -p $PORT &>/dev/null
    getStatus "Copying ssh key"
}

cmsDetector() {
    read -p "Enter Magento 1/2 root directory path (NOT PUB). For example: /var/www/website (default: '~/public_html): " cmsPath
    if [[ -z $cmsPath ]];then
        cmsPath="~/public_html"
    fi
    read -p "Enter MySQL host (default: localhost): " mysqlHost
    if [[ -z $cmsPath ]];then
        mysqlHost="localhost"
    fi
    if ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "stat $cmsPath/app/etc/local.xml" &>/dev/null
    then
        cms="m1"
        mediaPath="$cmsPath"
        configPath="$cmsPath/app/etc/local.xml"
    elif ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "stat $cmsPath/app/etc/env.php" &>/dev/null
    then
        cms="m2"
        mediaPath="$cmsPath/pub"
        configPath="$cmsPath/app/etc/env.php"
    else
        echo "$(red)###Error: Unknown CMS!$(regular)"
        exit 1
    fi
}
mediaGet() {
    ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "cd $mediaPath;tar --exclude='cache' -zcvf - media" > $USER'_media.tgz'
    getStatus "Media download"
}

sqlExport() {
    if [[ $cms == "m1" ]];then
        sqlDataInfo=`ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "cat $configPath" | grep "username\|password\|dbname" | awk -F"[" {'print $3'} | awk -F"]" {'print $1'} | tr "\n" " "`
        dbName=`echo $sqlDataInfo | awk {'print $3'}`
        dbUser=`echo $sqlDataInfo | awk {'print $1'}`
        userPass=`echo $sqlDataInfo | awk {'print $2'}`
    elif [[ $cms == "m2" ]];then
        sqlDataInfo=`ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "cat $configPath" | grep "username\|password\|dbname" | awk -F"=>" {'print $2'} | awk -F"'" {'print $2'} | tr "\n" " "`
        dbName=`echo $sqlDataInfo | awk {'print $1'}`
        dbUser=`echo $sqlDataInfo | awk {'print $2'}`
        userPass=`echo $sqlDataInfo | awk {'print $3'}`
    fi
    ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "cd ~;mysqldump -h $mysqlHost '$dbName' -u'$dbUser' -p'$userPass' -v --skip-triggers --single-transaction | gzip -9" > auto_$dbName.sql.gz && gzip -d auto_$dbName.sql.gz
    getStatus "SQL download"
}

clearData() {
    ssh $USER@$HOST -p $PORT -i /tmp/$tmpKeyName "sed -i /'$tmpKeyName'/d ~/.ssh/authorized_keys"
    rm -f /tmp/$tmpKeyName*
}
sshCopyId() {
    if ! stat ~/.ssh/id_rsa.pub &>/dev/null
    then
        echo "$(red)###Error: Public key ~/.ssh/id_rsa.pub not found. You need to copy id_rsa and id_rsa.pub to ~/.ssh/ folder$(regular)"
        exit 1
    fi
    if [[ -z $PORT ]];then
        PORT="22"
    fi

    if [[ -z $HOST ]];then
        echo "$(red)Hostname or ip address is missing$(regular)"
        exit 1
    fi
    read -p "Enter login: " USER
    ssh-copy-id -i ~/.ssh/id_rsa.pub $USER@$HOST -p $PORT &>/dev/null
    getStatus "Try to connect: ssh $USER@$HOST -p $PORT. SQL copy key"
}

case $1 in
    "media")
        sshKeygen
        cmsDetector
        mediaGet
        clearData
    ;;
    "sql")
        sshKeygen
        cmsDetector
        sqlExport
        clearData
    ;;
    "both")
        sshKeygen
        cmsDetector
        mediaGet
        sqlExport
        clearData
    ;;
    "ssh")
        sshCopyId
    ;;
    *)
        echo -e "Usage: /bin/bash $0 [media|sql|both|ssh] [hostname or ip address] [port (default 22)]\n"
        echo "media - copying media files in archive to the local node"
        echo "sql - create sql dump and download to the local node"
        echo "both - download media and sql dump to the local node"
        echo -e "ssh - copy ssh public key to the remote node\n"
        echo -e "\tExamples: /bin/bash $0 media test.com"
        echo -e "\t\t  /bin/bash $0 sql test.com 2288"
    ;;
esac
