#! /bin/bash
sudo systemctl start mariadb
echo set root password
echo Type Y to remove the anonymous user accounts.

echo Type Y to disable the remote root login.

echo Type Y to remove the test database.

echo Type Y to reload the privilege tables and save your changes.

read -t 10 -p "Read the instruction above and press enter"

sudo mysql_secure_installation
sudo systemctl restart mariadb
sudo systemctl enable mariadb
