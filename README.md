# LEAP 5.0 Internship project for Tribe - O

### 360-Degree Monitoring for Cloud Servers using Nagios-Core and Zabbix

- We are going to use separate EC2 instances just to monitor the the remote Hosts/Servers that we need to monitor.
- Also we are going to setup this as to decentralize this monitoring service in case one goes down.

> NOTE: For the sake of convinience We atleast need 4 to maximum 5 EC2 instances to implement this on testing level atleast and same amount of Elastic IP addresses to associate them with all the server so you won't have to reconfigure them all the time.

## Why Nagios or Zabbix ?

Traditionally AWS Cloudwatch or services like that are very easy to implement on the infrastructure you have, the reason why we are going with Nagios-Core and Zabbix these are Open Source monitoring tools. They charge nothing, totally free of cost monitoring for all of the instances/servers/appliances you have. Also, it gives accurate statistical information about the modules you have activated.


## Total Monitoring Modules :
First of all we are going to go with Network Monitoring :
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
 
Then there is Webserver/Application Webserver Monitoring
  - Tomcat
  - Xampp
  - Any Website
  - Servers with particular Ports
