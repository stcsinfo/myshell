First install ecryptfs-utils (it may already be installed)

sudo apt-get install ecryptfs-utils
then boot to recovery mode and as root run

ecryptfs-migrate-home -u your_user_to_migrate
After the script runs, log out and log in as your user

exit
You might also with to run

ecryptfs-unwrap-passphrase
enter your use password when prompted and save the information in a safe place in the event you need to perform data recovery.

Last you can delete the temp files / directories created by the migration script and reboot (technically you do not need to reboot).