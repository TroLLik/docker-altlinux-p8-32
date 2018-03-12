#!/bin/bash

ALT_P8_IMG="alt-p8-ovz-generic-20171212-i586.tar.xz"
MD5_FROM_FTP=$(curl -s http://nightly.altlinux.org/p8/release/MD5SUM | grep ${ALT_P8_IMG} | awk '{ print $1 }')
TARGET_FILE=basealt.tar.xz


function download(){
	wget --progress=bar:force --output-document=${TARGET_FILE} https://mirror.yandex.ru/altlinux-starterkits/release/${ALT_P8_IMG}
        if [[ $? -eq 0 ]]
        then
                echo 'Download completed'
                exit 0
        else
                echo 'Download failed'
                exit 1
        fi   
	}

if [[ -f ./${TARGET_FILE} ]]
then 
	echo 'The file exist'
    echo 'Check md5sum...'
    MD5_FROM_FILE=$(md5sum ${TARGET_FILE} | awk '{ print $1 }')
    if [[ ${MD5_FROM_FILE} == ${MD5_FROM_FTP} ]]
	then
		echo -e '\033[37;1;42m OK!!! \033[0m Files md5sum equals. File up to date'
		exit 0
	else
		echo -e "\033[37;1;41m WARNING!!! \033[0m Files md5sum not equals. The file not last actual or file are broken!"
        echo "The file will be redownloaded..."
        rm -rf ${TARGET_FILE}
        download
	fi        
else
	echo 'The file does not exist'
    echo 'Starting download the file'
    download
fi