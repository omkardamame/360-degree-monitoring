#!/bin/bash

echo ""
echo ""
echo "#############################################################"
echo "#############################################################"
echo "##                                                         ##"
echo "##       Welcome to Nagios Auto Installation Script        ##"
echo "##               Written By Omkar Damame                   ##"
echo "##                 Written For Ubuntu                      ##"
echo "#############################################################"
echo "#############################################################"

echo ""
echo ""
echo "############### Fulfilling prerequisites ###############"
echo "############### Downloading packages and updating repos ############### "
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev

echo ""
echo ""
echo "############### Installing OpenSSL libraries###############"
sudo apt-get install openssl libssl-dev

echo ""
echo ""
echo "############### Downloading the Soruce ###############"
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar xzf nagioscore.tar.gz

echo ""
echo ""
echo "############### Compiling ###############"
cd /tmp/nagioscore-nagios-4.4.6/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all

echo ""
echo ""
echo "############### Creating user and group ###############"
sudo make install-groups-users
sudo usermod -a -G nagios www-data

echo ""
echo ""
echo "############### Installing binaries ###############"
sudo make install

echo ""
echo ""
echo "############### Installing Service/Daemon ###############"
sudo make install-daemoninit

echo ""
echo ""
echo "############### Installing Command Mode ###############"
sudo make install-commandmode

echo ""
echo ""
echo "############### Installing Configuration Files ###############"
sudo make install-config

echo ""
echo ""
echo "############### Installing Apache Config Files ############### "
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi

echo ""
echo ""
echo "############### Configure Firewall ###############"
sudo ufw allow Apache
sudo ufw reload

echo ""
echo ""
echo "############### Creating Nagios Admin User Account ############### "

sleep 2

echo "Enter your username: "
read line1

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users $line1


#When adding additional users in the future, you need to remove -c from the above command. 
#Otherwise it will replace the existing nagiosadmin user (and any other users you may have added).

echo ""
echo ""
echo "############### Starting Apache Web Server ###############"

sleep 2

sudo systemctl restart apache2.service

echo ""
echo ""
echo "############### Starting Nagios Core ###############"
sudo systemctl enable nagios
sudo systemctl start nagios.service

sleep 2

echo "############### Script has been executed successfully! ###############"