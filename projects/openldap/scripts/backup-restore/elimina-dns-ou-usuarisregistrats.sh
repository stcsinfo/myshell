#!bin/bash
ldapsearch -x -H ldap://localhost -s one -D cn=admin,dc=$username_ba_ldap,dc=local -b ou=UsuarisRegistrats,ou=extern,dc=$username_ba_ldap,dc=local cn -LLL -W | awk -F": " '$1~/^\s*dn/{print $2}' > dn-a-eliminar.txt && ldapdelete -r -f dn-a-eliminar.txt -D cn=admin,dc=$username_ba_ldap,dc=local  -W
