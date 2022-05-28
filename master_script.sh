#!/bin/bash

echo ""
echo ""
echo "#############################################################"
echo "#############################################################"
echo "##                                                         ##"
echo "##       Welcome to Nagios Auto Installation Script        ##"
echo "##               Written By Prasad Dhupkar                 ##"
echo "##               Written For Ubuntu 20.04                  ##"
echo "#############################################################"
echo "#############################################################"

echo ""
echo "############### Getting Necessary Files ###############"
cd /tmp/
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-core.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-nrpe.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-plugins.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/Nagios%20Server%201.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/Nagios%20Server%202.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/Instance%202.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/Webserver.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/Zabbix%20Server.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/contacts.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/commands.cfg

echo ""
echo ""
echo ""
sudo chmod u+x nagios-core.sh
sudo chmod u+x nagios-nrpe.sh
sudo chmod u+x nagios-plugins.sh
echo ""
echo ""
echo ""
echo "############################## Executing Required Scripts ##############################"
echo ""
echo ""

./nagios-core.sh
sleep 5
./nagios-nrpe.sh
sleep 5
./nagios-plugins.sh
echo ""
echo "####################################################################################"
echo "############################## Execution Successful ! ##############################"
echo "####################################################################################"
echo ""
