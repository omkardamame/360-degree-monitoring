# LEAP 5.0 Internship project for Tribe - O

### 360-Degree Monitoring for Cloud Servers using Nagios-Core and Zabbix

- We are going to use multiple EC2 instances inorder to monitor the the remote Hosts/Servers that we need to monitor.
- Also we are going to setup this as to decentralize this monitoring service in case one goes down.

> NOTE: For the sake of convenience, we need minimum 4 to maximum 7 EC2 instances to implement this on testing level and same amount of Elastic IP addresses to associate with them so we don't have to access them all the time with different IPs.


## What is Nagios ?
It's an Open-Source monitoring tool that monitors almost everything for free. It uses NRPE and Nagios Plugins to fetch the monitored data from remote hosts and sends it back to the nagios server. After which we can see that data on a web-interface provided by nagios which can be hosted locally as well using public IP with which you can get to know if there is any problem with remote hosts. In that case there is a mailing service as well named postfix that uses SMTP protocol to send user a mail explaining the problem and the server name in which the problem has occurred. 

## What is Zabbix ?
It's also another Open-Source monitoring tool that we have used in case of the nagios server going down because of any reason. This Service uses Database that is hosted on the zabbix server to store all the information that it receives from remote hosts. To monitor remote hosts you need to install zabbix agent which will then be linked with the main zabbix server. It also provides web-interface for the user to go through and resolve if any issues came up.

## Why Nagios or Zabbix ?

Traditionally, AWS Cloudwatch or services like that are very easy to implement on the infrastructure you have, the reason why we are going with Nagios-Core and Zabbix these are Open Source monitoring tools. They charge nothing, totally free of cost monitoring for all of the instances/servers/appliances you have. Also, the tools give neccessary statistical information about the modules you have activated. They are not proprietory so that there are not security or privacy issues regarding sensitive infomation any company might have.

## Total Monitoring Modules :
We are going to go with Network Monitoring :
  - PING
  - SSH
  - HTTP
  - Packet Loss
  - No. of Users Logged In
  - Databases (MySQL in this case)

The next thing is, Hardware Monitoring :
  - CPU Load Average
  - RAM Usage
  - Root Partitions
  - Disk Usage
  - Total Procs
 
Then there is Webserver/Application Monitoring
  - Tomcat
  - Xampp
  - Any Website
  - Servers with particular Ports
