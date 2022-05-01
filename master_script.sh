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
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-core.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-nrpe.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-plugins.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/client1.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/client2.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/contacts.cfg

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
