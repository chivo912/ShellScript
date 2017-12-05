#!/bin/sh

# Script automatic add domain Apache2
# Date: 05-12-2017
# Script Author : Chi Vo
# Homepage : www.chivo.org
# Version 1.0.2
# Login Root First
# Usage : ./add-domain.sh chivo.org /home/chivo/public_html/

#Check root
if [[ ! "$(whoami)" == "root" ]] ; then

	echo "Requesting su permissions..."
	# Run this script with sudo privs
	sudo $0 $*
		# If running this script with su privs failed, advise to do so manually and exit
		if [[ $? > 0 ]] ; then
		echo
		echo "Acquiring su permission failed!"
		echo "Please run this script with sudo permissions!"
		echo "(e.g. 'sudo $0' or 'sudo bash $0')"
		echo
		exit 1
	fi
exit 0
fi

#Get parameters
domain=$1
path=$2
if [ "$domain" ]; then
	echo $domain
else
	echo "Input your domain : "
	read domain
fi

if [ "$path" ]; then
	echo $path
else
	echo "Input your path : "
	read path
fi

#Run
echo '127.0.0.1 '$domain >> /etc/hosts
echo '<VirtualHost *:80>' > /etc/apache2/sites-available/$domain'.conf'
echo '	ServerName '$domain >> /etc/apache2/sites-available/$domain'.conf'
echo '	ServerAdmin webmaster@'$domain >> /etc/apache2/sites-available/$domain'.conf'
echo '	DocumentRoot '$path >> /etc/apache2/sites-available/$domain'.conf'
echo '	<Directory '$path'>' >> /etc/apache2/sites-available/$domain'.conf'
echo '		Options FollowSymLinks' >> /etc/apache2/sites-available/$domain'.conf'
echo '		AllowOverride All' >> /etc/apache2/sites-available/$domain'.conf'
echo '		Order allow,deny' >> /etc/apache2/sites-available/$domain'.conf'
echo '		Allow from all' >> /etc/apache2/sites-available/$domain'.conf'
echo '		Require all granted' >> /etc/apache2/sites-available/$domain'.conf'
echo '	</Directory>' >> /etc/apache2/sites-available/$domain'.conf'
echo '</VirtualHost>' >> /etc/apache2/sites-available/$domain'.conf'
echo '# vim: syntax=apache ts=4 sw=4 sts=4 sr noet' >> /etc/apache2/sites-available/$domain'.conf'
a2ensite $domain
service apache2 restart

