#!/bin/bash

#user details
read -p "uid :" uid
read -p "sn :" sn
read -p "cn :" cn
read -p "user password :" pass 

echo "dn: uid=$uid,dc=zoo,dc=local
objectClass: top
objectClass: person
objectClass: inetOrgPerson
uid: $uid
sn: $sn
cn: $cn
userPassword: $pass" > users.ldif 

ldapadd -x -D "cn=admin,dc=zoo,dc=local" -W -f users.ldif

exit 0