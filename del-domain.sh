#!/bin/sh

# Script automatic delete domain Apache2
# Date: 06-12-2017
# Script Author : Chi Vo
# Homepage : www.chivo.org
# Version 1.0.2
# Login Root First
# Usage : ./del-domain.sh chivo.org

echo
echo '#################################################################'
echo '# Script automatic delete domain Apache2			#'
echo '# Date: 05-12-2017						#'
echo '# Script Author : Chi Vo					#'
echo '# Homepage : www.chivo.org					#'
echo '# Version 1.0.1							#'
echo '# Login Root First						#'
echo '# Usage : ./del-domain.sh chivo.org				#'
echo '#################################################################'
echo

#Check root
user=$(whoami)
if [ ! "$user" = 'root' ]; then
	echo 'Root permission : '
	sudo $0 $*
	exit
fi

#Get parameters
domain=$1

if [ ! "$domain" ]; then
	echo "Input your domain : "
	read domain
fi

check_domain_existed=$(grep -c "$domain" /etc/hosts)

if [ "$check_domain_existed" = 0 ] ; then
	echo 'Domain not found !'
	exit
fi

sed '/'$domain'/ d' /etc/hosts > /tmp/hosts_bak
mv /tmp/hosts_bak /etc/hosts
a2dissite $domain
rm -f /etc/apache2/sites-available/$domain.conf
service apache2 restart
echo 'Domain "'$domain'" has been deleted !'
