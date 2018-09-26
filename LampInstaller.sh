#!/bin/bash

#Instructions to use this script 
#
#chmod +x SCRIPTNAME.sh
#
#sudo ./SCRIPTNAME.sh

echo "\n\n###########################################################################################\n"
echo "Please be Patient: Installation will start now.......and it will take some time :)"
echo "\n#############################################################################################\n"

#Update the repositories

sudo apt-get update

installation=1;

#Apache, Php, MySQL and required packages installation

if [ "`lsb_release -ds`" = "Ubuntu 16.04.5 LTS" ]
then

echo "\n\n ********************************  INSTALLATION STARTED *************************************";
echo "\n\n###########################################################################################\n";
echo "#                                 Installing Apache Server                                     #";
echo "\n#############################################################################################\n";


if [ $? -eq 0 ]; then

    echo "\n--------------------------  Apache Installation Success..!  ---------------------\n";

else

    echo "\n-------------------------   Apache Installation Failed..!  -----------------------\n";
    echo "\n$error\n";
    installation=0;

fi



echo "\n\n#############################################################################################\n";
echo "#             Installing PHP with libapache2,mcrypt,mysql extensions                            #";
echo "\n###############################################################################################\n";
#sudo apt-get -y install php libapache2-mod-php php-mcrypt php-mysql 

sudo apt-get install software-properties-common
sudo add-apt-repository ppa:ondrej/php

sudo apt update
sudo apt install php7.2 libapache2-mod-php7.2

if [ $? -eq 0 ]; then

    echo "\n-------------------   PHP Installation Success..! -----------------------------------\n";

else
    echo "\n--------------------   PHP Installation Failed..!  -----------------------------------\n";
     echo "\n$error\n";
     installation=0;
fi

echo "\n\n#############################################################################################\n";
echo "                              Installing MYSQL Server Start                                     #";
echo "\n ##############################################################################################\n";

sudo apt-get -y install mysql-server

if [ $? -eq 0 ]; then

    echo "\n-------------------   MYSQL Installation Success..!  ---------------------------------\n";

else
    echo "\n-------------------   MYSQL  Installation Failed..!  ---------------------------------\n";
    echo "\n$error\n";
    installation=0;
fi


#The following commands set the MySQL root password to MYPASSWORD123 when you install the mysql-server package.

#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
#sudo apt-get -y install mysql-server

#Restart all the installed services to verify that everything is installed properly



echo "\n\n###########################################################################################\n";
echo ".............................RESTARTING APACHE AND MYSQL  SERVICES............................#";
echo "\n#############################################################################################\n";

    sudo chmod 755 -R /var/www/;
    sudo printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php;
    service apache2 restart && service mysql restart > /dev/null


if [ $? -eq 0 ]; then

    echo " \n--------------------  Restart MYSQL and PHP Service  Success..! ---------------------------\n";

else
    echo "\n---------------------  Restart Apache MYSQL service  Failed..!  -----------------------------\n";
    echo "\n$error\n";
    installation=0;
fi


echo "\n\n#################################################################################################\n";
echo "                             CHECKING APACHE CONFIGURATIONS...........................              #";
echo "\n###################################################################################################\n";

sudo apache2ctl configtest

echo "\n";

#sudo ufw app list

echo "\n---------------------------------------- Apache Firewall State -----------------------------------\n";

sudo ufw app info "Apache Full"

echo "\n---------------------------------------- Enable Firewall Rules -----------------------------------\n";

sudo ufw allow in "Apache Full"

if [ $installation -eq 1 ]; then

echo "\n\n##################################################################################################\n";
echo "------------------------- INSTALLATION COMPLETED ---------------------------------------------------";
echo "\n#####################################################################################################\n";

else

echo "\n\n##################################################################################################\n";
echo "------------------------- INSTALLATION NOT COMPLETED ---------------------------------------------------";
echo "\n#####################################################################################################\n";


echo $installation;

fi

else

echo "########################################################################################################";
echo "Un supported operating system 'This Script Need Ubuntu 16.04 LTS ' Version Operating System.";
echo "########################################################################################################";

fi
