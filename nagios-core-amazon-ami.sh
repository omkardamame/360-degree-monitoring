#!/bin/bash

echo ""
echo ""
echo "#############################################################"
echo "#############################################################"
echo "##                                                         ##"
echo "##       Welcome to Nagios Auto Installation Script        ##"
echo "##                Written By Omkar Damame                  ##"
echo "##                Written For Amazon AMI                   ##"
echo "#############################################################"
echo "#############################################################"

echo ""
echo ""
echo "############### Fulfilling prerequisites ###############"
echo "############### Downloading packages and updating repos ############### "
sudo yum update
sudo yum install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev

echo ""
echo ""
echo "############### Installing OpenSSL libraries###############"
sudo yum install openssl libssl-dev -y

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

echo "Default username: nagiosadmin"
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

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

echo ""
echo ""
echo "############### Changing Timezone ###############"
sudo timedatectl set-timezone Asia/Kolkata

echo ""
echo ""
echo "############### Auto Configuring cgi.cfg ###############"
sudo sh -c "sed -i 's/^authorized_for_system_information=.*/authorized_for_system_information=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_configuration_information=.*/authorized_for_configuration_information=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_system_commands=.*/authorized_for_system_commands=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_services=.*/authorized_for_all_services=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_hosts=.*/authorized_for_all_hosts=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_service_commands=.*/authorized_for_all_service_commands=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"
sudo sh -c "sed -i 's/^authorized_for_all_host_commands=.*/authorized_for_all_host_commands=nagiosadmin, $line1/g' /usr/local/nagios/etc/cgi.cfg"

sudo sh -c "sed -i 's/^refresh_rate=.*/refrash_rate=30/g' /usr/local/nagios/etc/cgi.cfg"


echo ""
echo ""
echo "############### Auto Configuring nagios.cfg ###############"
echo "Enter your admin email: "
read line2
sudo sh -c "sed -i 's/^admin_email=.*/admin_email=$line2/g' /usr/local/nagios/etc/nagios.cfg"
sudo sh -c "sed -i 's|#cfg_dir=/usr/local/nagios/etc/servers|cfg_dir=/usr/local/nagios/etc/servers|g' /usr/local/nagios/etc/nagios.cfg"

sudo mkdir /usr/local/nagios/etc/servers
sudo chown nagios:nagios /usr/local/nagios/etc/servers

cp /home/ec2-user/client1.cfg /usr/local/nagios/etc/servers/client1.cfg
cp /home/ec2-user/client2.cfg /usr/local/nagios/etc/servers/client2.cfg

sudo chown nagios:nagios /usr/local/nagios/etc/servers/client1.cfg
sudo chown nagios:nagios /usr/local/nagios/etc/servers/client2.cfg

sudo systemctl restart apache2.service
sudo systemctl restart nagios.service

echo "############### Script has been executed successfully! ###############"
