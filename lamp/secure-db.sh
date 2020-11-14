#! /bin/bash
sudo systemctl start mariadb
echo set root password
echo Type Y to remove the anonymous user accounts.

echo Type Y to disable the remote root login.

echo Type Y to remove the test database.

echo Type Y to reload the privilege tables and save your changes.

sudo mysql_secure_installation
sudo systemctl start mariadb
sudo systemctl enable mariadb
