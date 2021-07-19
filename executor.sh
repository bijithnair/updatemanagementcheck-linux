#!/bin/bash


 

unamestr=`uname`


 

if [ `cat /etc/os-release | grep  ID | grep -i ubuntu |  cut -d "=" -f2` == ubuntu ]; then

hostnm=`hostname`

Package_installed=`if [ -s /lib/systemd/system/unattended-upgrades.service ]; then systemctl list-unit-files | grep unattended-upgrades | awk '{print $2}'; else echo "Missing"; fi`

platform=`cat /etc/os-release | grep  ID | grep -i ubuntu |  cut -d "=" -f2`

Apply_updates=`if [ -s  /etc/apt/apt.conf.d/20auto-upgrades ]; then cat /etc/apt/apt.conf.d/20auto-upgrades| grep -i Unattended-Upgrade | awk '{print $2}' | cut -d ";" -f1; else echo "Missing"; fi`

release=`cat /etc/os-release  | grep VERSION= | cut -d "=" -f2`

else


 

if [ "$unamestr" == 'Linux' ]; then


 

platform=`uname`

hostnm=`hostname`

Package_installed=`rpm -qa | grep yum-cron &> /dev/null; if [ $? -eq 0 ]; then  echo "Installed"; else echo "Missing"; fi`

Apply_updates=`if [ -s /etc/yum/yum-cron.conf ]; then cat /etc/yum/yum-cron.conf | grep apply_updates | awk '{print $3}'; else echo "Missing"; fi`

release=`cat /etc/*release | grep release | head -1`

fi

fi


 

echo -e "Hostname;Operating_System;OS_Release;Package_Installed;Service;Auto_Apply_Updates"

echo -e  "$hostnm;$platform;$release;$Package_installed;$Apply_updates"
