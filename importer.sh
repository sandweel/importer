#!/usr/bin/env bash

tmpKeyName="insecure_key"
HOST="$2"
PORT="$3"
DATE=`date +%d_%m-%H_%M`

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
bold()
{
    printf "\e[1m"
}

getStatus() {
    if [[ $? != 0 ]];then
        echo "$(red)$@ failed!$(regular)"
        exit 1
    else
        echo "$(green)$@ finished successfully!$(regular)"
    fi
}

selfUpdate() {
    SCRIPT=$0
    SCRIPTPATH=$(dirname "$SCRIPT")
    SCRIPTNAME="importer.sh"
    BRANCH="master"

    echo "$(bold)Checking for updates...$(regular)"
    cd $SCRIPTPATH
    if [[ ! -d $SCRIPTPATH/.git ]];then
        echo "$(red)You are running scripts outside GIT. Please clone origin script using 'git clone git@github.com:sandweel/importer.git' and run inside GIT'$(regular)"
        exit 1
    fi
    git fetch &>/dev/null
    if [[ -n `git diff --name-only origin/$BRANCH | grep $SCRIPTNAME` ]];then
        git reset --hard &>/dev/null
        echo "Found a new version of me, updating myself..."
        git pull --force &>/dev/null && \
        echo "$(green)Updated. Re-run script again!$(regular)" || \
        echo "$(red)Not updated. Try to clone it manually: 'git clone git@github.com:sandweel/importer.git'$(regular)"
        exit 1
    else
        echo "$(bold)The latest version!$(regular)"
    fi
}
prepare() {
    sshPass=`which sshpass 2>/dev/null`
    pvFile=`which pv 2>/dev/null`

    if [[ `uname | grep -c [Ll]inux 2>/dev/null` == "1" ]];then
        bashShell="/bin/bash"
        osType="Linux"
    elif [[ `uname | grep -c [Dd]arwin 2>/dev/null` == "1" ]];then
        bashShell="/usr/local/bin/bash"
        bashShellArm="/opt/homebrew/bin/bash"
        osType="OSX"
    else
        echo "$(red)Not supported OS: $(uname)"
        exit 1
    fi

    if [[ $osType == "OSX" ]];then
        if [ ! -f $bashShell ] && [ ! -f $bashShellArm ];then
            echo "$(bold)Bash 4+ is missing. Trying to install...$(regular)"
            brew install bash
            getStatus "Shell bash installation"
            echo "$(bold)Need to re-run the script$(regular)"
            exit 0
        fi
#        if [[ $(which bash) != "/usr/local/bin/bash" || $(which bash) != "/opt/homebrew/bin/bash" ]];then
#            echo -e "$(red)###Error: Script interpreter $(which bash) is not valid for importer.\nPlease use: $bashShell $0$(regular)"
#            exit 1
#        fi
    fi

    if [ ! -f "$pvFile" ]; then
        if [[ $osType == "Linux" ]];then
            echo "$(bold)PV is missing. Trying to install...$(regular)"
            sudo apt install pv
            getStatus "PV installation"
        elif [[ $osType == "OSX" ]];then
            echo "$(bold)PV is missing. Trying to install...$(regular)"
            brew install pv
            getStatus "PV installation"
        fi
    fi
    if [ ! -f "$sshPass" ]; then
        if [[ $osType == "Linux" ]];then
            echo "$(bold)SSHPASS is missing. Trying to install...$(regular)"
            sudo apt install sshpass
            getStatus "SSHPASS installation"
        elif [[ $osType == "OSX" ]];then
            echo "$(bold)SSHPASS is missing. Trying to install...$(regular)"
            brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
            getStatus "SSHPASS installation"
        fi
    fi
    if [[ $osType == "OSX" ]];then
        grepKey=2
    else
        grepKey=1
    fi
}

selfUpdate
prepare


sshKeygen() {
    if [[ -z $PORT ]];then
        PORT="22"
    fi

    if [[ -z $HOST ]];then
        echo "$(red)Hostname or ip address is missing$(regular)"
        exit 1
    fi
    read -p "Enter ssh login: " USER
    read -p "Enter ssh password or leave empty: " PASSWORD
    if [[ -z $PASSWORD ]];then
        sshKeys="id_rsa id_dsa rsa"
        for key in $sshKeys
        do
            if [[ -f "$HOME/.ssh/$key" ]];then
                sshKey="$HOME/.ssh/$key"
                break
            fi
        done
        cp $sshKey /tmp/$tmpKeyName
        chmod 600 /tmp/$tmpKeyName
        eval `ssh-agent` &> /dev/null
        ssh-add /tmp/$tmpKeyName &> /dev/null
        getStatus "Generation ssh key"
        sshExec="ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no $USER@$HOST -i /tmp/$tmpKeyName -p $PORT"
    else
        sshExec="sshpass -p$PASSWORD ssh -o PasswordAuthentication=yes -o IdentitiesOnly=yes -o StrictHostKeyChecking=no $USER@$HOST -p $PORT"
    fi
    $sshExec "echo 'true' > /dev/null"
    getStatus "SSH session open"
}

cmsDetector() {
    read -p "Enter Magento 1/2 root directory path (NOT PUB). For example: /var/www/website (default: '~/public_html): " cmsPath
    if [[ -z $cmsPath ]];then
        cmsPath="~/public_html"
    fi
    phpTmpFile="/tmp/.importer_config_parse.sh"
    cConf=`$sshExec "stat $cmsPath/app/etc/local.xml &>/dev/null && echo 1 && exit 0 || stat $cmsPath/app/etc/env.php &>/dev/null && echo 2 && exit 0"`
    if [[ $cConf == "1" ]];then
        cms="m1"
        mediaPath="$cmsPath"
        configPath="$cmsPath/app/etc/local.xml"
        configPathFile="app/etc/local.xml"
    elif [[ $cConf == "2" ]];then
        cms="m2"
        mediaPath="$cmsPath/pub"
        configPath="$cmsPath/app/etc/env.php"
        configPathFile="app/etc/env.php"
    else
        echo "$(red)###Error: Couldn't find config file inside directory: $(bold)$cmsPath$(regular). Double check project directory!$(regular)"
        exit 1
    fi
}
mediaGet() {
    echo "Calculation media directory size..."
    mediaSize=`$sshExec "du -sb $mediaPath/media/" | awk {'print $1'}`
    declare -i mistake=$mediaSize/100
    declare -i percent=$mistake*16
    declare -i pvMediaSize=$mediaSize-$percent
    hMediaSize=$(echo "$pvMediaSize/1073741824" | bc -l | awk '{printf "%f", $0}' | cut -c-4)
    echo -e "\nMedia size - $hMediaSize""G"
    $sshExec "cd $mediaPath;tar --exclude='cache' -zcf - media/*" | pv -b -c -p -r -s $pvMediaSize > $USER'_media.tar.gz'
    getStatus "Media download. Media archive file: $USER'_media.tar.gz'"
}
publicDataGet() {
    echo "Calculation project directory size..."
    publicDataSize=`$sshExec "du -sb $cmsPath/" | awk {'print $1'}`
    declare -i mistake=$publicDataSize/100
    declare -i percent=$mistake*16
    declare -i pvPublicDataSize=$publicDataSize-$percent
    hPublicDataSize=$(echo "$pvPublicDataSize/1073741824" | bc -l | awk '{printf "%f", $0}' | cut -c-4)
    echo -e "\nPublic data size - $hPublicDataSize""G"
    $sshExec "cd $cmsPath;tar --exclude='cache' -zcf - ./" | pv -b -c -p -r -s $pvPublicDataSize > $USER'_public.tar.gz'
    getStatus "Media download. Media archive file: $USER'_public.tar.gz'"
}
sqlExport() {
    if [[ $cms == "m1" ]];then
        declare -A sqlDataInfo=$($sshExec "cd $cmsPath; php -r \"\\\$a=file_get_contents('$configPathFile'); \\\$p=xml_parser_create(); xml_parse_into_struct(\\\$p, \\\$a, \\\$vals, \\\$index); print('( [dbhost]='.\\\$vals[(\\\$index['HOST'][0])]['value'].' ');print('[dbname]='.\\\$vals[(\\\$index['DBNAME'][0])]['value'].' ');print('[dbuser]='.\\\$vals[(\\\$index['USERNAME'][0])]['value'].' ');print('[dbpass]='.\\\$vals[(\\\$index['PASSWORD'][0])]['value'].' )');\"")

        dbHost=$(echo ${sqlDataInfo[dbhost]})
        dbName=$(echo ${sqlDataInfo[dbname]})
        dbUser=$(echo ${sqlDataInfo[dbuser]})
        userPass=$(echo ${sqlDataInfo[dbpass]})
    elif [[ $cms == "m2" ]];then
        echo "<?php" > $phpTmpFile
        echo "\$a = require('$configPathFile');" >> $phpTmpFile
        echo "print('([dbhost]='.\$a['db']['connection']['default']['host']);" >> $phpTmpFile
        echo "print(' [dbname]='.\$a['db']['connection']['default']['dbname']);" >> $phpTmpFile
        echo "print(' [dbuser]='.\$a['db']['connection']['default']['username']);" >> $phpTmpFile
        echo "print(' [dbpass]='.\$a['db']['connection']['default']['password'].')');" >> $phpTmpFile

        if [[ -z $PASSWORD ]];then
            rsync -e "ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no -p $PORT -i /tmp/$tmpKeyName" $phpTmpFile $USER@$HOST:$phpTmpFile
        else
            sshpass -p$PASSWORD rsync -e "ssh -o PasswordAuthentication=no -o StrictHostKeyChecking=no -p $PORT" $phpTmpFile $USER@$HOST:$phpTmpFile
        fi

        declare -A sqlDataInfo=$($sshExec "cd $cmsPath; php $phpTmpFile")
        dbHost=$(echo ${sqlDataInfo[dbhost]})
        dbName=$(echo ${sqlDataInfo[dbname]})
        dbUser=$(echo ${sqlDataInfo[dbuser]})
        userPass=$(echo ${sqlDataInfo[dbpass]})
    fi

    if [[ ! -z $userPass ]];then
        mysqlPassKey="-p'$userPass'"
    fi

    dbSize=`$sshExec "mysql -h $dbHost -u$dbUser $mysqlPassKey -e \"SELECT table_schema, ROUND(SUM(data_length + index_length) / 1024 / 1024 / 12, 2) AS 'SIZE' FROM information_schema.TABLES where table_schema = '$dbName' GROUP BY table_schema;\"" |  awk {'print $2'} | grep -v SIZE`
    echo "$(bold)Estimated compressed db file size: $dbSize""M$(regular)"
    $sshExec "cd ~;mysqldump -h '$dbHost' '$dbName' -u'$dbUser' $mysqlPassKey --no-tablespaces --routines --skip-triggers --single-transaction 2>/dev/null | gzip -9" | pv -b -c -r > auto_$dbName"_"$DATE.sql.gz

    echo "$(bold)Decompressing...$(bold)"
    gzip -d auto_$dbName"_"$DATE.sql.gz
    getStatus "SQL download. SQL archive file: auto_$dbName'_'$DATE.sql.gz"
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

clearData() {
    rm -f /tmp/$tmpKeyName
    ssh-agent -k &> /dev/null
}

showVersion() {
    version="2.0.1"
    echo "$(bold)Importer version is $version $(regular)"
}

case $1 in
    "media")
        sshKeygen
        cmsDetector
        mediaGet
        clearData
    ;;
    "public")
        sshKeygen
        cmsDetector
        publicDataGet
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
        sqlExport
        mediaGet
        clearData
    ;;
    "ssh")
        sshCopyId
    ;;
    version|-v|--version)
        showVersion
    ;;
#    "test")
#        sshKeygen
#    ;;
    *)
        echo -e "Usage: bash $0 [media|public|sql|both|ssh] [server ip address] [ssh port (default 22)]\n"
        echo "media - copying media files in archive to the local node"
        echo "public - copying root project directory (public_html) in archive to the local node"
        echo "sql - create sql dump and download to the local node"
        echo "both - download media and sql dump to the local node"
        echo -e "ssh - copy ssh public key to the remote node\n"
        echo -e "\tExamples: /bin/bash $0 media test.com"
        echo -e "\t\t  /bin/bash $0 sql test.com 2288"
    ;;
esac
