# LEAP 5.0 Internship project for Tribe - O

### 360-Degree Monitoring for Cloud Servers using Nagios-Core

- We are going to use separate EC2 instances just to monitor the the remote Hosts/Servers that we need to monitor.
- Also we are going to setup this as to decentralize this monitoring service in case one goes down.

> NOTE: We atleast need 4 and Maximum Five EC2 Instances to implement this on atleast of testing level and same amount of Elastic IP addresses to associate them with all the server so you wont have to reconfigure all the time

## Why Nagios ?

Traditionally AWS Cloudwatch or services like that are very easy to implement on the infrastructure you have, the reason is Nagios-Core is OpenSource monitoring tool. It charges the company nothing, totally free of cost monitoring for all of the servers you have. It also gives accurate statistical information about the modules you have activated.

## Total Monitoring Modules :
First of all we are going to go with Network Monitoring :
  - PING
  - SSH
  - HTTP
  - Packet Loss
  - Users Logged In
  - Databases (MySQL)

The next thing is Hardware Monitoring :
  - CPU Load Average
  - RAM Usage
  - Root Partitions
  - Disk Usage
  - Total Procs
 
Then there is Webserver/ Application Webserver Monitoring
  - Tomcat
  - Xampp
  - Website
  - Servers with particular Ports




  
