clear
cyan; echo "### IMPORTA ###"  '';nocolor
echo  ""
echo  'mysql -u username -p database_name < file.sql'  ''
cyan; echo " "
cyan; echo "### EXPORTA ###"'';nocolor
echo  ""
echo  ""'mysqldump -u root -p database_name > /docker-entry-point/database_name.sql"'  ''
echo  ""
cyan; echo "### INSERT / UPDATE ###";nocolor
echo  " "'INSERT INTO version_upgrader (id, n_release, nom_arxiu) VALUES (3, ''0sistemes'', update_1_7_15.sql);' ''
echo  " "'UPDATE version_upgrader SET n_release = '0sistemes' WHERE id = 3;' ''
echo  ""
cyan; echo "### USUARIS ###";nocolor
echo  " "     "SELECT User, Host FROM mysql.user;'" ''
echo  ""
cyan; echo "### PERMISOS ###";nocolor
cyan; echo "    ### CREAR ###";nocolor
echo  " "     "CREATE USER 'username'@'%' IDENTIFIED BY 'password';" ''
echo  " "     "GRANT SELECT, INSERT, UPDATE, DELETE ON databasename.* TO 'username'@'%';" ''
echo  " "     "FLUSH PRIVILEGES;" ''
cyan; echo "    ### REVOKE ###" '';nocolor
echo  " "     "REVOKE ALL PRIVILEGES ON databasename.* FROM 'username'@'%';" ''
cyan; echo "    ### LLISTAR ###";nocolor
echo  " "     "SHOW GRANTS for 'username';" ''
echo  ""
cyan; echo "### OTROS ###";nocolor
echo  " "show variables like "'max_connections';" ''
echo  " "show status where '`variable_name´' = "'Threads_connected';" ''
echo  ""
cyan; echo "Exemple user amb permisos per dumps";nocolor
echo  " "     "REVOKE ALL PRIVILEGES ON *.* FROM 'username'@'%';" ''
echo  " "     "REVOKE ALL PRIVILEGES ON databasename.* FROM 'username'@'%';" ''
echo  " "     "GRANT USAGE, PROCESS, LOCK TABLES ON *.* TO 'username'@'%';" ''
echo  " "     "GRANT SELECT, LOCK TABLES ON databasename.* TO 'username'@'%';" ''
echo  " "     "FLUSH PRIVILEGES;" '';nocolor
echo  " "     "SHOW GRANTS for 'username';" ''