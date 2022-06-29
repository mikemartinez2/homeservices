Will need to add USER acct to sudoers for no passwords before running script

sudo visudo

add the following under "%sudo   ALL=(ALL:ALL) ALL" line:

# Allow user $USER_NAME to sudo without password
$USER_NAME ALL=(ALL) NOPASSWD:ALL

