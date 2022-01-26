#!/usr/bin/env bash

awsKey="
LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS1FJQkFBS0NBZ0VBcjdDNTBMYUdP
aEE1NHF6dXFsUEF4ZVliSkxXT1BDVnUzRGtIRWZndktiZXFETUJUCkJKa1AyNHgvQ2VQWFQyS2FO
OHFJdTVPL1VKMyt3Y1lLUlg2eWtoc2IzZTUxMTJ4Wk5hbnlSZFpVZ0ZvaGtwUkYKeGV1bFkrYkxL
KytFcDZHeDdoUXdDSWJwZW95QllpT1J0ZndOVG1PZjJ5MVZCRmo2QzBTMUdjbTZHU09tUUpudgpN
UGdSeUZVZlY1UkFiZjROQVJrRnpEdFlVZXFkVzluRDIwQlJSMHRhYzZ0YzZjWkp0TVNYNkJvYk92
TWNSOVB4Ck95R0JhRzI3Qy9STXBhSlAzdVVQbjdlcVVjcngvSlRWdVJDemxvY0RaYmc3b3QvbVNZ
VURMbkkyRlErZE9Jd2sKUTFNRjZtbmdKK2RaWkxZdGVHUkhmVCtFRmRCeWJQQWprSmNDQ0tucDZW
RnZBdVNtVGRGV3Fya2lhbzJDSGsvbApQK0pQREFlVXU2T1pCc29xSzJqV0MydXU1bnF4OUhtZy9K
NXNaUFRMbzRXajNsNkNFRUxXQzVLNVVOdnB0enU2CnJGVk5kNDFBQmZ2M2psbXhjcmc2M05YT2lQ
a081bDNLbHpjeUNMSTNESkgwUkFJQ0U4NVludmc0L1RmZkhkb3cKNlRIQnUyL3N6enMxWkJKdFpM
eFU4RFAwOUcwQ2FYSmJLNDlmNHhnbzdVSFJpTU5DQnl6RHIwemJmRVZDeFMwQQpNU1JXbCtOam56
L0lpaHQzRFFjZmc3ZW1EclB1d1J2YkY1MWFLUnczSjlDb0RPQ3krbU9rc0ZSSUZBMlRoS2pJCmZ2
bSt3OWpqbDhSTlhkSkZoRjEwNXVSK1kwWDdocERpdEJvYlZOeTZibkhpMDNDQzBCUzM1ejNBeE5z
Q0F3RUEKQVFLQ0FnQjJYZ0N5eDJaamxDOExzeXNSQW1Cc2RIMXhIQWo2S05ZcDlSbjRWMWVmS2Fp
ZDhxMTcrWXVmaFdiSgp5UUYwOEorcVd3QUlNS0RDdGMrL3lhZDk3c0JzZzJzZytObllDNTJHOURy
UUpuakVDUFY1aGdBRU9xRXhUM3N1CjNLNXBLaDF3bzVWQkNYUWdKcTI4NnUzdXlDUkczZ1FEYk9W
TWlvM2NMYXc5OVpVMS9yaXg2WVFuWDlyTE45NW4KNlBBSHF4UWoyekgyeVR6VjQ5V2szbkNBTlRN
TmI0MC9SUUxTVmMrdXhJejd5U3J6YW50eFFTL1RnTjFvK0JULwpGdGJVK1NnS3FoVCtySVZKbWd1
eStxdUxoZDhZMlZuR25IdEJYc3dPV0ZrdVg3QmtQQ0xXeUVSZVAzOUswWTQrCkZEWThEaWxRWlc5
c3lQQTZxamVOZ2JUVVk0andJdkExeTNITGdGZGhWREY5ZDJtbjVFc0FOVXlCRTVHRitXUEsKS0Mv
SDM0cEovRzJEeVc0M0h3OWVtOENzVStnZU0rRytKZWwzajM3NjJSM3BkNXRVT3ZoTlAzQW5pU1Fs
RWF6WQpxOE5ZYlVPSExPeU9QVFhscGliaUMraGVpZWZYL2Vzdm1hcEwvcWgrb0ZBb2MwYk4vR01E
eGtzVCszZGNrdG1ZCmNCVlI0ZnRmQk1YTzZRSmw5SDNwMW1qU29hT3hvUHQ0eFJnT3NtM2czcDZO
R2pZR1pCZTRoZ1VCTkx6RzFZWEwKTk1kZWJkaUVMZGdPT085YzFtUUdtMW5acWpCV1JrU2w1R2Ez
czBFMGRBZDFKdHgyUTlFSXJTYitsdWRwbElhOQpWTXRFRmNuckJPd3lUbWhvbDQ0Zy8zanF4WklX
Y1o4dTQxOXFyNHJhVFN2SGVydnRzUUtDQVFFQTRzL2xNcFIxCjFyTkZ2T3NiOHU3K2JkMktrSWFH
bVEyOFFESWYrSlhDcHpqQnkzMHRiUjNCbklac25QeGRqeFd1ZThzZ1BXSXEKSEZUL3VKUTI5blFo
Q0EydkhrdFFpVUczM1pOekdKVnZPbnE3ZVRlZmVpSy9ZaXNrM1ZOakhrMitYQ3duKysvaQovMHp3
dXZtb3p4SWVKSDREbkpZczNkZkdTQ09Jc29xNjVwVEllRzBaR0NwKzBPMm0wQ0tCdEdXNjBrVGRD
cWhqCllldzFySzV4ZTM0ZlRvbDRMNHM1cWlaUTVsNGcvMXR0K25YRjF0cHNnSW9OVE5Xc3BMUVVT
RklLOTRETkJIWmsKY2V6c0c1dDBLa2lzUjVybTRKeDB4T3pJUHNOZHFKY3RqRUxCbWZhSUJxK1E5
eHk0QlhPS2VKam5tVnlUcGN0TwpzTDdHa0NLZXBFcXFKUUtDQVFFQXhreXNma1FpL0xPSTlTMG10
VjV2Wk5kZ0Zpd0FiUU5WdU9GWFNiQ1RpV2NDCkVsL25rU2twVmlBaVRLK0ZXVVZVZi91a2RiUG5C
T3lMTUNSV3pJenJWRjlYVGRiWVl0ekkzd0l4NjdoMmIwSjQKckRZdlRpdzZtZ0YvZFpNbGtPM1Zs
Ri9uZzhvRTlTOGQvZlhwTmlldjkzeFVGWnNNRVp6d01QSW5ueEl6SVZzMQpObllaWDZvNnFjYkcy
a2g1WHVsOG9OMXVseGx5VUwwRFpPSDBlRmxWL25nYkQyWDNYT0xhMGpxNXBGVUV1THJ6CkZSQ1lv
VWhpUTRGcHVLR1FHc3cyRmM1d0xKWU51TlNsSExRQ3cxcWxZVXo1Qnl4K1hLRG9IQ0xLWE1paDRm
OUgKQWpWSmJ4WldwcUoxaktRRHg0bms5OUtCV0J2dnF3N3lZbG9ZVDhrQy93S0NBUUJqV0xDSjRT
RmtjNDNlWEJVWAo2YnNrSUYvclFpRit0TmQ2UHZwbUJpTUc0QU55d0ZlL2JjTTZibDd3dkZHMnRN
YUNqc3lHVnBNZmFkUEE0NXJYCmhMSmJOck0zejhGcy9ZNHR6Y0lpU0lJNTJUeDRzZloycHZXeGFE
aHpnV3p1L3hxY2dQTGFsWTZXU1B0QXlzNDQKTlRWaXdwZU9aUEV1RXE5Vk5jdFFlUmU0bS83YlVO
NG5DYVlXbWFIeGxNdS9XcmZrRmluRDIxSDh1RndpVVI1LworeFIzY0J0bXA5TVFSa3cxTzVHMGlE
VzUrUkE1TmQ5RXhqTmhMazY2cmU0Y1oyTktXZTV6UC9CclBsMkZFaWhsCnhRTkJNZ1ppNStUMXhN
bEpSSVduck9CVWlZRUhrVWF2dHdNR1dsdjRkMDExMlhQSVp4WjlEbnBmVEpEbzNXRWoKa1ZqSkFv
SUJBUUNLN1k3d0M1YWppcmtLWks2NDVNZVFVK0JxeURzb0pPejYwVTFSUUZldExURGpaTE9kSE1S
cwpKYWxDSnJwN0Y3cWl5OCtsOHZ1SWxKelRocklWTHlsMGZETnpRbkZwbWh0Vk9ubDFGMUJLbEx4
c2txM0R5L0xtCmtPUVdvSmZ5R043SXpBUXNiZTNaUlVCeSs4Visvb0VuRjhEbFBqSlBhSzlTNjJU
YzZtaE9GMU9KcTJZTmd2c0UKbFZJZC9pYWlXMXpJYXpxZXUrSStOSjViSUg4aGpoMVVZaHM3UjRu
dFZyWk9FWHljYUVBZG1FVFQza1BBd3pDcwo4TTc3M3AxU1dQNFBld2xXQTI3cnJuZGJTN2FmM1RM
K24ybmRIOHdMNDJPYXlya1NGakpzWG1nR1lRVG93akxGCkhnN1RFTm5oQTNnYU5DNFFaOG9iQXli
SHh5MC9RS3BMQW9JQkFRQ1pDWlZUZ01Oc0NMWlJmS3EyQWdoYUt1OFcKZW8veHZ2U1U3VjFJNXRH
QU9ocUV3YndmODJ1bndLVXpUU3Z6bFd5ODVZZmtLQTI1QzI0c1Y3dXBtUXF3aUNNQwpORERSVXZJ
dGpOTnJmVXVqeWgxRCtlSitJSVBJRGkrZ2pHYU1EUDgzMkdkZ1JaS3dUK3VaYnVSczVEZWtCV3J1
CkNVcFVpYnJrWkZPOFhhdklxeFRCRGJkQmZJWDFYdG1vZ0cwajNvMVRHckxhZC9xelA2WmJKaFVG
TmNlNHFpa24KVHpvaGNZUnNCL0xSd2M1bWxvN05vdU1NTlpXMUFtV3NZaE00SUtxdFE3REw5VmhU
V3I2bkoxSDdNRVFBZU1kYwp6bnVsWkFROVN0SC9QM1JzSTdZY1RLRTllc29uZjZuT2Rua2FXQ0FH
QnlDeHhlNCttbGx3UHRQcmg1MmoKLS0tLS1FTkQgUlNBIFBSSVZBVEUgS0VZLS0tLS0K
"
tmpKeyName="aws_insecure_key"
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
        echo "$(red)You are running scripts outside GIT. Please clone origin script using 'git clone git@bitbucket.org:absolutewebservices/importer.git' and run inside GIT'$(regular)"
        exit 1
    fi
    git fetch &>/dev/null
    if [[ -n `git diff --name-only origin/$BRANCH | grep $SCRIPTNAME` ]];then
        git reset --hard &>/dev/null
        echo "Found a new version of me, updating myself..."
        git pull --force &>/dev/null && \
        echo "$(green)Updated. Re-run script again!$(regular)" || \
        echo "$(red)Not updated. Try to clone it manually: 'git clone git@bitbucket.org:absolutewebservices/importer.git'$(regular)"
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
    #echo $awsKey | tr " " "\n" | base64 --decode > /tmp/$tmpKeyName
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
        echo <<EOF 1>/dev/null
Fixing MC syntax lighting"
EOF
        dbHost=$(echo ${sqlDataInfo[dbhost]})
        dbName=$(echo ${sqlDataInfo[dbname]})
        dbUser=$(echo ${sqlDataInfo[dbuser]})
        userPass=$(echo ${sqlDataInfo[dbpass]})
    elif [[ $cms == "m2" ]];then
        declare -A sqlDataInfo=$($sshExec "cd $cmsPath; php -r \"\\\$a = require('$configPathFile'); print '( [dbhost]='.\\\$a['db']['connection']['default']['host']; print ' [dbname]='.\\\$a['db']['connection']['default']['dbname']; print ' [dbuser]='.\\\$a['db']['connection']['default']['username']; print ' [dbpass]='.\\\$a['db']['connection']['default']['password'] . ' )';\"")
        echo <<EOF 1>/dev/null
Fixing MC syntax lighting"
EOF
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
