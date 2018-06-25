#!/bin/sh

# Script automatic add domain Apache2
# Date: 05-12-2017
# Script Author : Chi Vo
# Homepage : www.chivo.org
# Version 1.0.2
# Login Root First
# Usage : ./add-domain.sh chivo.org /home/chivo/public_html/

#Check root
user=$(whoami)
if [ ! "$user" = 'root' ]; then
	echo 'Root permission : '
	sudo $0 $*
	exit
fi

# Color
LIGHTRED='\033[1;31m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m'

echo
echo '#################################################################'
echo '# Script automatic add domain Apache2			     	#'
echo '# Date: 05-12-2017						#'
echo '# Script Author : Chi Vo					#'
echo '# Homepage : www.chivo.org					#'
echo '# Version 1.1.0							#'
echo '# Login Root First						#'
echo '# Usage : ./add-domain.sh chivo.org /home/chivo/public_html/	#'
echo '#################################################################'
echo

#Get parameters
domain=$1
path=$2
if [ ! "$domain" ]; then
	echo "Input your domain : "
	read domain
fi

if [ ! "$path" ]; then
	echo "Input your path : "
	read path
fi

# Check domain
check_domain_existed=$(grep -c "$domain" /etc/hosts)

if [ "$check_domain_existed" != 0 ] ; then
	echo "${RED}Domain ${LIGHTRED}$domain${RED} has already !\n"
	exit
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
echo "${GREEN}Domain ${LIGHTGREEN}$domain${GREEN} has been installed !\n"
