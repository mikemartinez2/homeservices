# Update sudoers list
sudo cp /etc/sudoers /tmp/sudoers.bak
sudo echo "# #Allow user $USER_NAME to sudo without password
$USER ALL=(ALL) NOPASSWD:ALL
" >> /tmp/sudoers.bak

# Check syntax of the backup file to make sure it is correct.
sudo visudo -cf /tmp/sudoers.bak
if [ $? -eq 0 ]; then
  # Replace the sudoers file with the new only if syntax is correct.
  sudo cp /tmp/sudoers.bak /etc/sudoers
else
  echo "Could not modify /etc/sudoers file. Please do this manually."
fi
