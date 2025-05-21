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
}
del_user() {
	read -p "what is the users uid :" uids
	ldapdelete -x -D "cn=admin,dc=zoo,dc=local" -W "uid=$uids,dc=zoo,dc=local"
	echo "done!"
}

while [ "$script" = 1 ]; do
	read -p "do you want to create a user or delete a user:(1=create.2=delete.3=exit)" what
	
	if [[ "$what" = "1" ]]; then
		new_user
	elif [[ "$what" = "2" ]]; then
		del_user
	elif [[ "$what" = "3" ]]; then
		echo "Exiting..."
		script=0

	else 
		echo "invalid. pick 1, 2, or 3"
		exit 0
	fi
done


