#!/bin/bash

echo ""
echo ""
echo "############################################################################"
echo "############################################################################"
echo "##                                                                        ##"
echo "##             Welcome to Nagios Core Auto Installation Script            ##"
echo "##                       Written By Omkar Damame                          ##"
echo "##                       Written For Ubuntu 20.04                         ##"
echo "##                                                                        ##"
echo "############################################################################"
echo "############################################################################"

echo ""
echo ""
echo "############################## Fulfilling prerequisites ##############################"
echo "############################## Downloading packages and updating repos ############################## "
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev

echo ""
echo ""
echo "############################## Installing OpenSSL libraries ##############################"
sudo apt-get install openssl libssl-dev -y

echo ""
echo ""
echo "############################## Downloading the Soruce ##############################"
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.6.tar.gz
tar xzf nagioscore.tar.gz

echo ""
echo ""
echo "############################## Compiling ##############################"
cd /tmp/nagioscore-nagios-4.4.6/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all

echo ""
echo ""
echo "############################## Creating user and group ##############################"
sudo make install-groups-users
sudo usermod -a -G nagios www-data

echo ""
echo ""
echo "############################## Installing binaries ##############################"
sudo make install

echo ""
echo ""
echo "############################## Installing Service/Daemon ##############################"
sudo make install-daemoninit

echo ""
echo ""
echo "############################## Installing Command Mode ##############################"
sudo make install-commandmode

echo ""
echo ""
echo "############################## Installing Configuration Files ##############################"
sudo make install-config

echo ""
echo ""
echo "############################## Installing Apache Config Files ############################## "
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi

echo ""
echo ""
echo "############################## Configure Firewall ##############################"
sudo ufw allow Apache
sudo ufw reload

echo ""
echo ""
echo "############################## Creating Nagios Admin User Account ############################## "
echo ""

echo "Default username: nagiosadmin"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sleep 2

echo ""
echo "Enter your new username: "
read line1

sudo htpasswd /usr/local/nagios/etc/htpasswd.users $line1

echo ""
echo ""
echo "############################## Starting Apache Web Server ##############################"

sleep 2

sudo systemctl restart apache2.service

echo ""
echo ""
echo "############################## Starting Nagios Core ##############################"
sudo systemctl enable nagios
sudo systemctl start nagios.service

sleep 2

echo ""
echo ""
echo "############################## Changing Timezone ##############################"
sudo timedatectl set-timezone Asia/Kolkata

echo ""
echo ""
echo "############################## Auto Configuring cgi.cfg ##############################"
sudo sh -c "sed -i 's/^authorized_for_system_information=.*/authorized_for_system_information=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_configuration_information=.*/authorized_for_configuration_information=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_system_commands=.*/authorized_for_system_commands=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_services=.*/authorized_for_all_services=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_hosts=.*/authorized_for_all_hosts=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_service_commands=.*/authorized_for_all_service_commands=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_host_commands=.*/authorized_for_all_host_commands=nagiosadmin,$line1/g' /usr/local/nagios/etc/cgi.cfg"

sudo sh -c "sed -i 's/^refresh_rate=.*/refrash_rate=15/g' /usr/local/nagios/etc/cgi.cfg"

echo ""
echo ""
echo "############################## Auto Configuring nagios.cfg ##############################"
echo ""
echo "Enter your admin email: "
read line2
echo ""

sudo sh -c "sed -i 's/nagios@localhost/$line2/g' /usr/local/nagios/etc/objects/contacts.cfg"

#sudo sh -c "sed -i 's/^admin_email=.*/admin_email=$line2/g' /usr/local/nagios/etc/nagios.cfg"
sudo sh -c "sed -i 's|#cfg_dir=/usr/local/nagios/etc/servers|cfg_dir=/usr/local/nagios/etc/servers|g' /usr/local/nagios/etc/nagios.cfg"
sudo sh -c "sed -i 's|cfg_file=/usr/local/nagios/etc/objects/localhost.cfg|#cfg_file=/usr/local/nagios/etc/objects/localhost.cfg|g' /usr/local/nagios/etc/nagios.cfg"


sudo mkdir /usr/local/nagios/etc/servers
sudo chown nagios:nagios /usr/local/nagios/etc/servers

cp /tmp/Instance\ 2.cfg /usr/local/nagios/etc/servers/Instance\ 2.cfg
cp /tmp/Nagios\ Server\ 1.cfg /usr/local/nagios/etc/servers/Nagios\ Server\ 1.cfg
cp /tmp/Nagios\ Server\ 2.cfg /usr/local/nagios/etc/servers/Nagios\ Server\ 2.cfg
cp /tmp/Webserver.cfg /usr/local/nagios/etc/servers/Webserver.cfg
cp /tmp/Zabbix\ Server.cfg /usr/local/nagios/etc/servers/Zabbix\ Server.cfg
cp /tmp/contacts.cfg /usr/local/nagios/etc/objects/contacts.cfg
cp /tmp/commands.cfg /usr/local/nagios/etc/objects/commands.cfg

sudo chown nagios:nagios /usr/local/nagios/etc/servers/Instance\ 2.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/servers/Nagios\ Server\ 1.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/servers/Nagios\ Server\ 2.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/servers/Webserver.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/servers/Zabbix\ Server.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/objects/contacts.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/objects/commands.cfg

sudo systemctl restart apache2.service
sudo systemctl restart nagios.service

echo "################################################################################################################"
echo "############################## Nagios Core Script has been executed successfully! ##############################"
echo "################################################################################################################"
