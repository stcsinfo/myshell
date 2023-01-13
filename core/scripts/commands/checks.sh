#!/bin/bash
source "$project_path"/core/scripts/functions/colors.sh
clear
#
red; echo ">"$(white)"Core"$(nocolor);
#
blue;echo -e OS_RELEASE=$( grep PRETTY_NAME /etc/os-release  | grep -o -P '(?<=").*(?=")'  );nocolor
blue;echo -e UP_TIME=$( uptime -p  );nocolor
blue;echo -e SHELL_VERSION=$( $SHELL --version );nocolor
if [ -d /etc/apt ]
then
        green;echo "apt system";nocolor
else
        red;echo "not an apt system";nocolor
fi
#
echo ""
red; echo ">"$(white)"Important modules require:"$(nocolor);
# docker
docker_groups=$(cat /etc/group | grep docker | awk -F: '{ printf $1}')
docker_str="docker"
if [ "$docker_groups" = "$docker_str" ]
        then
        green;echo "docker found";nocolor
        else
        red;echo "docker not found";nocolor
fi
## k8s
check_kubectl=$(kubectl &> /dev/null; echo $?)
if [ "$check_kubectl" = "0" ]
        then
        green;echo "kubectl found";nocolor
        else
        red;echo "kubectl not found";nocolor
fi
#
# powershell
powershell_yes=$(cat /etc/shells | grep -Eo 'pws[a-z]+' | head -1)
powershell="pwsh"
if [ "$powershell_yes" = "$powershell" ]
        then
        green;echo "powershell found";nocolor
        else
        red;echo "powershell not found";nocolor
fi
#
# yq
if [ -e /usr/bin/yq ]
then
        green;echo "yq found";nocolor
else
        red;echo "yq not found";nocolor
        #sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64
        #sudo chmod a+x /usr/local/bin/yq
fi
# openssl
check_openssl=$(dpkg -l openssl 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
openssl="openssl"
if [ "$check_openssl" = "$openssl" ]
then
        green;echo "openssl found";nocolor
else
        red;echo "openssl not found";nocolor
fi
# john
check_john=$(dpkg -l john 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
john="john"
if [ "$check_john" = "$john" ]
then
        green;echo "john the ripper found";nocolor
else
        red;echo "john the ripper not found";nocolor
fi
# sqlmap
check_sqlmap=$(dpkg -l sqlmap 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
sqlmap="sqlmap"
if [ "$check_sqlmap" = "$sqlmap" ]
then
        green;echo "sqlmap found";nocolor
else
        red;echo "sqlmap not found";nocolor
fi
# metasploit-framework
check_metasploit_framework=$(dpkg -l metasploit-framework 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
metasploit_framework="metasploit-framework"
if [ "$check_metasploit_framework" = "$metasploit_framework" ]
then
        green;echo "metasploit-framework found";nocolor
else
        red;echo "metasploit-framework not found";nocolor
fi
# yt-dlp
check_yt_dlp=$(dpkg -l yt-dlp 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
yt_dlp="yt-dlp"
if [ "$check_yt_dlp" = "$yt_dlp" ]
then
        blue;echo "yt-dlp found";nocolor
else
        blue;echo "yt-dlp not found";nocolor
fi
#
echo ""
red; echo ">"$(white)"Additional system configs:"$(nocolor);
# cups
cups_yes=$(dpkg -l cups 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
cups="cups"
if [ "$cups_yes" = "$cups" ]
then
        yellow;echo "cups found";nocolor
else
        green;echo "cups not found";nocolor
fi
#
# IPv6
inet6_yes=$(ip a | grep -i inet6 | head -1 | awk '{ printf $1}')
inet6="inet6"
if [ "$inet6_yes" = "$inet6" ]
then
        yellow;echo "inet6 found";nocolor
        #echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf
        #echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf
        #echo "net.ipv6.conf.lo.disable_ipv6=1" >> /etc/sysctl.conf
        #sudo sysctl -p
else
        green;echo "inet6 not found";nocolor
fi
#
# snapd
check_snapd=$(dpkg -l snapd 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
snapd="snapd"
if [ "$check_snapd" = "$snapd" ]
then
        yellow;echo "snapd found";nocolor
else
        green;echo "snapd not found";nocolor
fi
#
# rsyslog
rsyslog_yes=$(dpkg -l rsyslog 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
rsyslog="rsyslog"
if [ "$rsyslog_yes" = "$rsyslog" ]
then
        green;echo "rsyslog found";nocolor
else
        yellow;echo "rsyslog not found";nocolor
fi
#
# apt-transport-https
apt_transport_https_yes=$(dpkg -l apt-transport-https 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
apt_transport_https="apt-transport-https"
if [ "$apt_transport_https_yes" = "$apt_transport_https" ]
then
        green;echo "apt-transport-https found";nocolor
else
        yellow;echo "apt-transport-https not found";nocolor
fi
# Shells
contenido=$(wc -l /etc/shells | awk '{printf $1}')
resultado=$(( contenido - 1 ))
blue;echo "$resultado" "shell(s) available";nocolor
#
# evolution
check_evolution=$(dpkg -l evolution 2> /dev/null | grep -i "ii" | awk '{ printf $2}')
evolution="evolution"
if [ "$check_evolution" = "$evolution" ]
then
        blue;echo "evolution found";nocolor
else
        blue;echo "evolution not found";nocolor
fi