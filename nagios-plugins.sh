#!/bin/bash

echo ""
echo ""
echo "############################################################################"
echo "############################################################################"
echo "##                                                                        ##"
echo "##          Welcome to Nagios Plugins Auto Installation Script            ##"
echo "##                       Written By Omkar Damame                          ##"
echo "##                       Written For Ubuntu 20.04                         ##"
echo "##                                                                        ##"
echo "############################################################################"
echo "############################################################################"

sleep 1

echo ""
echo ""
echo "############################## Installing Prerequisites ##############################"
echo ""
echo ""

sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext

echo ""
echo ""
echo "############################## Downloading the Soruce ##############################"
echo ""
echo ""

cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxf nagios-plugins.tar.gz

echo ""
echo ""
echo "############################## Compiling and Installing ##############################"
echo ""
echo ""

cd /tmp/nagios-plugins-release-2.2.1/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install

sudo mkdir -p /usr/lib/nagios/plugins/
cd /usr/lib/nagios/plugins/
sudo wget https://raw.githubusercontent.com/justintime/nagios-plugins/master/check_mem/check_mem.pl
sudo mv check_mem.pl check_mem
sudo mv check_mem /usr/local/nagios/libexec/
cd /usr/local/nagios/libexec/
chmod +x check_mem

echo ""
echo ""
echo "############################## Testing NRPE + Plugins ##############################"
echo ""
echo ""

/usr/local/nagios/libexec/check_nrpe -H 127.0.0.1 -c check_load
