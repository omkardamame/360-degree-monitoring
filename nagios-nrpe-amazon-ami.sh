#!/bin/bash

echo ""
echo ""
echo "#############################################################"
echo "##                                                         ##"
echo "##     Welcome to Nagios NRPE Auto Installation Script     ##"
echo "##               Written By Omkar Damame                   ##"
echo "##                 Written For Ubuntu                      ##"
echo "#############################################################"
echo "#############################################################"

sleep 1

echo ""
echo ""
echo "############### Installing Prerequisites ###############"
echo ""
echo ""

sudo yum update
sudo yum install -y autoconf automake gcc libc6 libmcrypt-dev make libssl-dev wget openssl

echo ""
echo ""
echo "############### Downloading the Soruce ###############"
echo ""
echo ""

cd /tmp
wget --no-check-certificate -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.0.3.tar.gz
tar xzf nrpe.tar.gz

echo ""
echo ""
echo "############### Compiling ###############"
echo ""
echo ""

cd /tmp/nrpe-nrpe-4.0.3/
sudo ./configure --enable-command-args --with-ssl-lib=/usr/lib/x86_64-linux-gnu/
sudo make all

echo ""
echo ""
echo "############### Creating User And Group ###############"
echo ""
echo ""

sudo make install-groups-users

echo ""
echo ""
echo "############### Installing Binaries ###############"
echo ""
echo ""

sudo make install

echo ""
echo ""
echo "############### Installing Configuration File ###############"
echo ""
echo ""

sudo make install-config

echo ""
echo ""
echo "############### Update Services File ###############"
echo ""
echo ""

sudo sh -c "echo >> /etc/services"
sudo sh -c "sudo echo '# Nagios services' >> /etc/services"
sudo sh -c "sudo echo 'nrpe    5666/tcp' >> /etc/services"

echo ""
echo ""
echo "############### Installing Service / Daemon ###############"
echo ""
echo ""

sudo make install-init
sudo systemctl enable nrpe.service

echo ""
echo ""
echo "############### Configuring Firewall ###############"
echo ""
echo ""

sudo mkdir -p /etc/ufw/applications.d
sudo sh -c "echo '[NRPE]' > /etc/ufw/applications.d/nagios"
sudo sh -c "echo 'title=Nagios Remote Plugin Executor' >> /etc/ufw/applications.d/nagios"
sudo sh -c "echo 'description=Allows remote execution of Nagios plugins' >> /etc/ufw/applications.d/nagios"
sudo sh -c "echo 'ports=5666/tcp' >> /etc/ufw/applications.d/nagios"
sudo ufw allow NRPE
sudo ufw reload

sleep 2

echo ""
echo ""
echo "############### UPDATE NRPE CONFIGURATION ON YOUR OWN ###############"
echo ""
echo ""
echo "############### SKIPPING CONFIGURATION PART ###############"

sleep 2

echo ""
echo ""
echo "############### Starting Service / Daemon ###############"
echo ""
echo ""

sudo systemctl start nrpe.service

sleep 5

echo ""
echo ""
echo "############### Testing NRPE ###############"
echo ""
echo ""

sudo /usr/local/nagios/libexec/check_nrpe -H 127.0.0.1

echo ""
echo ""
echo "Note :"
echo "The file nrpe.cfg is where the following settings will be defined. It is located: "
echo "/usr/local/nagios/etc/nrpe.cfg"
echo "If you wanted your nagios server to be able to connect, add it's IP address after a comma."
echo ""
echo ""
echo "You should see the output similar to the following if NRPE installation is successful:"
echo "NRPE v4.0.3"
