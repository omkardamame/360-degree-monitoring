
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

sudo apt-get update
sudo apt-get install -y autoconf automake gcc libc6 libmcrypt-dev make libssl-dev wget openssl

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

sleep 5

echo ""
echo ""
echo "############### UPDATE NRPE CONFIGURATION ON YOUR OWN ###############"
echo ""
echo ""
echo "############### SKIPPING CONFIGURATION PART ###############"

sleep 5

echo ""
echo ""
echo "############### Starting Service / Daemon ###############"
echo ""
echo ""

sudo systemctl start nrpe.service

echo ""
echo ""
echo "############### Testing NRPE ###############"
echo ""
echo ""

/usr/local/nagios/libexec/check_nrpe -H 127.0.0.1

#You should see the output similar to the following:

#NRPE v4.0.3

#If you get the NRPE version number (as shown above), NRPE is installed and configured correctly.
#You can also test from your Nagios host by executing the same command above, but instead of 127.0.0.1 you will need to replace that with the IP Address / DNS name of the machine with NRPE running.

#Service / Daemon Commands

#sudo systemctl start nrpe.service
#sudo systemctl stop nrpe.service
#sudo systemctl restart nrpe.service
#sudo systemctl status nrpe.service