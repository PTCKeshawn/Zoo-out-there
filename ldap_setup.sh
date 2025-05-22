#update the list of available packages
sudo apt update

#installs LDAP package
sudo apt install slapd ldap-utils 
#cn=admin,dc=zoo,dc=local

#reconfigure the LDAP server.
sudo dpkg-reconfigure slapd

#verify that LDAP is running
sudo systemctl status slapd

#adds base LDAP structure
sudo nano /etc/ldap.conf
#BASE dc=zoo,dc=local
#URI ldap://10.10.11.18

