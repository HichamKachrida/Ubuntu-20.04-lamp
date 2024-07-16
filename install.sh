#!/bin/sh

echo "\033[34mDébut de l'installation\033[0m"
echo "\033[34mMettre à jour la liste des paquets et mettre à niveau tous les paquets\033[0m"
sudo apt-get update
sudo apt-get upgrade -y

echo "\033[34mInstaller les outils de base\033[0m"
sudo apt-get install -y nano wget curl software-properties-common apt-transport-https lsb-release ca-certificates

echo "\033[34mDéfinir le nom d'hôte (ajustez selon les besoins)\033[0m"
sudo hostnamectl set-hostname votre-nom-de-serveur

echo "\033[34mInstaller Apache\033[0m"
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo systemctl start apache2

echo "\033[34mInstaller PHP et les modules nécessaires\033[0m"
sudo apt-get install -y php php-mysql libapache2-mod-php php-cli php-cgi php-gd

echo "\033[34mInstaller MariaDB\033[0m"
sudo apt-get install -y mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo mysql_secure_installation

echo "\033[34mInstaller Pure-FTPD\033[0m"
sudo apt-get install -y pure-ftpd
sudo systemctl enable pure-ftpd
sudo systemctl start pure-ftpd

echo "\033[34mInstaller BIND (serveur DNS)\033[0m"
sudo apt-get install -y bind9 bind9utils bind9-doc
sudo systemctl enable bind9
sudo systemctl start bind9

echo "\033[34mInstaller Postfix\033[0m"
sudo apt-get install -y postfix postfix-mysql postfix-doc bsd-mailx

echo "\033[34mInstaller Dovecot\033[0m"
sudo apt-get install -y dovecot-core dovecot-imapd dovecot-pop3d dovecot-mysql dovecot-sieve dovecot-managesieved

echo "\033[34mTélécharger et installer ISPConfig\033[0m"
cd /tmp
wget -O ispconfig.tar.gz https://www.ispconfig.org/downloads/ISPConfig-3-stable.tar.gz
tar xfz ispconfig.tar.gz
cd ispconfig3_install/install/
php -q install.php

echo "\033[34mRedémarrer les services pour appliquer les modifications\033[0m"
sudo systemctl restart apache2
sudo systemctl restart mariadb
sudo systemctl restart pure-ftpd
sudo systemctl restart bind9
sudo systemctl restart postfix
sudo systemctl restart dovecot

echo "\033[33mL'installation et la configuration du serveur parfait sont terminées !\033[0m"

echo "\033[33mRedemarrage du system.\033[0m"

sudo reboot
