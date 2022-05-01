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
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-core-amazon-ami.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-nrpe-amazon-ami.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/nagios-plugins-amazon-ami.sh
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/client1.cfg
sudo wget https://raw.githubusercontent.com/omkardamame/360-degree-monitoring/main/client2.cfg
echo ""
echo ""
echo ""
sudo chmod u+x nagios-core-amazon-ami.sh
sudo chmod u+x nagios-nrpe-amazon-ami.sh
sudo chmod u+x nagios-plugins-amazon-ami.sh
echo ""
echo ""
echo ""
echo "############### Executing Required Scripts ###############"
echo ""
echo ""

./nagios-core-amazon-ami.sh
sleep 2
./nagios-nrpe-amazon-ami.sh
sleep 2
./nagios-plugins-amazon-ami.sh
echo ""
echo ""
echo "############### Execution is Successfull! ###############"
echo ""
echo ""
