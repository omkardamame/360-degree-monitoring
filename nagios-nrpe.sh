#!/bin/bash

echo ""
echo ""
echo "############################################################################"
echo "############################################################################"
echo "##                                                                        ##"
echo "##            Welcome to Nagios NRPE Auto Installation Script             ##"
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
sudo apt-get install -y autoconf automake gcc libc6 libmcrypt-dev make libssl-dev wget openssl

echo ""
echo ""
echo "############################## Downloading the Soruce ##############################"
echo ""
echo ""

cd /tmp
wget --no-check-certificate -O nrpe.tar.gz https://github.com/NagiosEnterprises/nrpe/archive/nrpe-4.0.3.tar.gz
tar xzf nrpe.tar.gz

echo ""
echo ""
echo "############################## Compiling ##############################"
echo ""
echo ""

cd /tmp/nrpe-nrpe-4.0.3/
sudo ./configure --enable-command-args --with-ssl-lib=/usr/lib/x86_64-linux-gnu/
sudo make all

echo ""
echo ""
echo "############################## Creating User And Group ##############################"
echo ""
echo ""

sudo make install-groups-users

echo ""
echo ""
echo "############################## Installing Binaries ##############################"
echo ""
echo ""

sudo make install

echo ""
echo ""
echo "############################## Installing Configuration File ##############################"
echo ""
echo ""

sudo make install-config

echo ""
echo ""
echo "############################## Updating Services File ##############################"
echo ""
echo ""

sudo sh -c "echo >> /etc/services"
sudo sh -c "sudo echo '# Nagios services' >> /etc/services"
sudo sh -c "sudo echo 'nrpe    5666/tcp' >> /etc/services"

echo ""
echo ""
echo "############################## Installing Service / Daemon ##############################"
echo ""
echo ""

sudo make install-init
sudo systemctl enable nrpe.service

echo ""
echo ""
echo "############################## Configuring Firewall ##############################"
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
echo "############################## Configuring nrpe.cfg ##############################"
echo ""
echo ""

echo "Enter private IP of your server"
read ip

sudo sh -c "sed -i '/-r -w/ccommand[check_load]=\/usr\/local\/nagios\/libexec\/check_load -r -w .55,.30,.15 -c .70,.55,.30' /usr/local/nagios/etc/nrpe.cfg"
sudo sh -c "sed -i '/-w 20/ccommand[check_disk]=\/usr\/local\/nagios/libexec\/check_disk -w 20% -c 10% -p \/dev\/root' /usr/local/nagios/etc/nrpe.cfg"
sudo sh -c "sed -i '/-w 150 -c 200/ccommand[check_procs]=\/usr\/local\/nagios\/libexec\/check_procs -w 200 -c 300' /usr/local/nagios/etc/nrpe.cfg"

sudo sh -c "sed -i '305 a command[check_mem]=\/usr\/local\/nagios\/libexec\/check_mem -C -u -w 70 -c 90' /usr/local/nagios/etc/nrpe.cfg"
sudo sh -c "sed -i '306 a command[check_http]=/usr/local/nagios/libexec/check_http -H $ip -w 5 -c 10' /usr/local/nagios/etc/nrpe.cfg"
sudo sh -c "sed -i '307 a command[check_ssh]=/usr/local/nagios/libexec/check_ssh $ip' /usr/local/nagios/etc/nrpe.cfg"
sudo sh -c "sed -i '308 a command[check_ping]=/usr/local/nagios/libexec/check_ping -H $ip -w 100.0,20% -c 500.0,60% -p 5' /usr/local/nagios/etc/nrpe.cfg"

sudo sh -c "sed -i 's|^allowed_hosts=.*|allowed_hosts=127.0.0.1,192.168.20.0/24,172.31.0.0/16|g' /usr/local/nagios/etc/nrpe.cfg"


echo ""
echo ""
echo "############################## Starting Service / Daemon ##############################"
echo ""
echo ""

sudo systemctl start nrpe.service

sleep 5

echo ""
echo ""
echo "############################## Testing NRPE ##############################"
echo ""
echo ""

sudo /usr/local/nagios/libexec/check_nrpe -H 127.0.0.1
