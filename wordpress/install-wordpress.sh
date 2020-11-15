
#Below instructions are derived from https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress.html


echo downloading wordpress from https://wordpress.org/latest.tar.gz
wget https://wordpress.org/latest.tar.gz
/bin/rm -rf wordpress
tar -xzf latest.tar.gz
cp wordpress/wp-config-sample.php wordpress/wp-config.php

echo "Generate random password"
export pass=`dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev`

echo $pass > password.txt

if [[ $? != 0 ]]
then
        echo "Unable to store password file."
        exit 1
fi
echo "password is stored here. Make a note of it and delete the file"

wget https://api.wordpress.org/secret-key/1.1/salt/ -O salt.txt

define( 'DB_NAME', 'database_name_here' );
define( 'DB_USER', 'username_here' );
define( 'DB_PASSWORD', 'password_here' );


export pattern="'AUTH_KEY'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'SECURE_AUTH_KEY'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'LOGGED_IN_KEY'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'NONCE_KEY'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'AUTH_SALT'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'SECURE_AUTH_SALT'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'LOGGED_IN_SALT'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php

export pattern="'NONCE_SALT'"
export saltline=`grep "$pattern" salt.txt`
sed -i "/$pattern/c\\$saltline" wordpress/wp-config.php


sudo systemctl start mariadb
mysql -u root --password=$MYSQL_PASSWORD

cp -r wordpress/* /var/www/html/
   25  sudo vim /etc/httpd/conf/httpd.conf
sudo yum install php-gd -y
sudo chown -R apache /var/www
sudo chgrp -R apache /var/www
sudo chmod 2775 /var/www
find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
sudo systemctl restart httpd
sudo systemctl enable httpd && sudo systemctl enable mariadb
sudo systemctl status mariadb
sudo systemctl status httpd



 
