# Installation of Postfix

============================================================================================
```
sudo apt-get update
```
```
sudo apt-get install mailutils
```
```
sudo apt-get install libsasl2-modules postfix
```

When prompted, select Internet Site as the type of mail server the Postfix installer should configure. 
Just select ```<ok>``` and don't change system mail name or any other settings.

Once the installation is complete, confirm that the myhostname parameter is configured with your server’s FQDN:
Path is ```/etc/postfix/main.cf``` and parameter is
```
myhostname = fqdn.example.com
```
============================================================================================

Add Gmail Username and Password to Postfix
  
Open or create the ```/etc/postfix/sasl/sasl_passwd``` file and add the SMTP Host, username, and password information:
```
[smtp.gmail.com]:587 <youremail@gmail.com>:<yourgmailpassword>  
``` 
Save it and create the hash db file for Postfix by running the postmap command:
```
sudo postmap /etc/postfix/sasl/sasl_passwd
```
Secure Your Postfix Hash Database and Email Password Files:
```
sudo chown root:root /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```
```
sudo chmod 0600 /etc/postfix/sasl/sasl_passwd /etc/postfix/sasl/sasl_passwd.db
```
============================================================================================
 
Configure the Postfix Relay Server
  
```
sudo vim /etc/postfix/main.cf
```
Change the parameter of ```relayhost``` in main.cf
```
relayhost = [smtp.gmail.com]:587
```
At the end of the file, add the following parameters to enable authentication:
```
# Enable SASL authentication
smtp_sasl_auth_enable = yes
# Disallow methods that allow anonymous authentication
smtp_sasl_security_options = noanonymous
# Location of sasl_passwd
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
# Enable STARTTLS encryption
smtp_tls_security_level = encrypt
# Location of CA certificates
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
```

Save your changes and close the file.

Restart Postfix and Nagios:

```
sudo systemctl restart postfix
sudo systemctl restart nagios

```
============================================================================================

Test Postfix Email Sending With Gmail
```
sendmail recipient@elsewhere.com
From: you@example.com
Subject: Test mail
This is a test email
.
```
============================================================================================

Check for syslogs for errors or issues
```
sudo tail -f /var/log/syslog
```
References :

https://www.linode.com/docs/guides/configure-postfix-to-send-mail-using-gmail-and-google-workspace-on-debian-or-ubuntu/

https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-on-ubuntu-20-04
