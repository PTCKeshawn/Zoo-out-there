#!/bin/bash

script=1

#user details: using "read" to input user credentials
new_user() {
	read -p "uid :" uid
	read -p "sn :" sn
	read -p "cn :" cn
	read -p "user password :" pass 
	read -p "uid number :" uidnumber
	read -p "gid number :" gidnumber

	echo "dn: uid=$uid,dc=zoo,dc=local
	objectClass: inetOrgPerson
	objectClass: posixAccount
	objectClass: top
	uid: $uid
	sn: $sn
	cn: $cn
	uidNumber: $uidnumber
	gidNumber: $gidnumber
	homeDirectory: /home/$uid
	loginShell: /bin/bash
	userPassword: $pass" > users.ldif 

	ldapadd -x -D "cn=admin,dc=zoo,dc=local" -W -f users.ldif
	
	echo "creating user..."
	echo "done!"
}

del_user() {
	read -p "what is the users uid :" uids
	ldapdelete -x -D "cn=admin,dc=zoo,dc=local" -W "uid=$uids,dc=zoo,dc=local"
	echo "deleting..."
	sleep 2
	echo "done!"
	sleep 1
}

reset_password() {
	read -p "what is the users uid :" uidss
	sudo ldappasswd -x -D "cn=admin,dc=zoo,dc=local" -W \
  -S "uid=$uidss,dc=zoo,dc=local"
  	echo "resetting $uidss's password..."
  	sleep 2
  	echo "done"
  	sleep 1

}

while [ "$script" = 1 ]; do
	read -p "do you want to : \
	1.create a user \
	2.delete a user \
	3.reset a password \
	4.exit \
	>>>>>" what
	
	if [[ "$what" = "1" ]]; then
		new_user
	elif [[ "$what" = "2" ]]; then
		del_user
	elif [[ "$what" = "3" ]]; then
		reset_password
	elif [[ "$what" = "4" ]]; then
		echo "Exiting..."
		script=0

	else 
		echo "invalid. pick 1, 2, 3, or 4"
		exit 0
	fi
done