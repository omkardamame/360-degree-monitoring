# LEAP 5.0 Internship project for Tribe - O

### 360-Degree Monitoring for Cloud Servers using Nagios-Core and Zabbix

- We are going to use multiple EC2 instances inorder to monitor the the remote Hosts/Servers that we need to monitor.
- Also we are going to setup this as to decentralize this monitoring service in case one goes down.

> NOTE: For the sake of convenience, we need minimum 4 to maximum 7 EC2 instances to implement this on testing level and same amount of Elastic IP addresses to associate with them so we don't have to access them all the time with different IPs.

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
