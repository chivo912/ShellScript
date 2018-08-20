#!/bin/sh

# Script Install Composer
# Date: 24-07-2018
# Script Author : Chi Vo
# Homepage : www.chivo.ooo
# Version 1.0.0
# Install : ./install-composer.sh
# Usage : composer

# Color
LIGHTRED='\033[1;31m' #
RED='\033[0;31m' #
GREEN='\033[0;32m' #
LIGHTGREEN='\033[1;32m' #
NC='\033[0m' #

echo "${GREEN}" #
echo '#################################################################'
echo '# Script Install Composer				  	#'
echo '# Date: 24-07-2018						#'
echo '# Script Author : Chi Vo					#'
echo '# Homepage : www.chivo.ooo					#'
echo '# Version 1.0.0							#'
echo '# Install : ./install-composer.sh				#'
echo '# Usage : composer						#'
echo '#################################################################'
echo "${NC}" #

wget https://getcomposer.org/composer.phar -P ~/ #
echo "alias composer='php ~/composer.phar'" >> ~/.bashrc #
source ~/.bashrc #
echo #
echo "${GREEN} Composer installed successfully !" #
echo #


