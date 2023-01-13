#!/bin/bash
ldapsearch -x -H ldap://localhost -s one -D cn=admin,dc=$username_ba_ldap,dc=local -b ou=UsuarisRegistrats,ou=extern,dc=$username_ba_ldap,dc=local cn -LLL -W
