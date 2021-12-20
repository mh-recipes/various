#!/usr/bin/env bash
#
# This script depends on 'curl' so make sure it's installed.
#

username=CHANGEME
password=SETPASSWORD
host=SETHOST

###  N O  N E E D  T O  E D I T  A N Y  F U R T H E R  ###

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'        # No Color

# Check if curl exists.
command -v curl &> /dev/null 2>&1 || { printf >&2 "[${RED}ERROR${NC}] Please install curl or set it in your path. Aborting.\n"; exit 1; }
ip=`curl -s http://whatismyip.akamai.com/`

# Yes, very basic dirty ip check.
if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then

  url="https://dyndns.intention.nl/update?domain=$username&password=$password&hostname=$host&myip=$ip"
  do_curl=`curl -s "$url"`

  if [ "$do_curl" == "nochg" ]; then
    printf "[${YELLOW}SKIP${NC}] IP not updated.\n"
  elif [ "$do_curl" == "badauth" ]; then
    printf "[${RED}ERROR${NC}] Please check your username and/or password.\n"
  elif [ "$do_curl" == "good" ]; then
    printf "[${GREEN}OK${NC} IP updated to: $ip\n"
  else
    printf "[${RED}ERROR${NC}] $do_curl\n"
  fi
else
  printf "[${RED}ERROR${NC}] No valid ip returned.\n"
fi
