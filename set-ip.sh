#!/usr/bin/env bash
# Script to set a static IP using nmcli
## using a specified interface.
## For systems using nmcli

# Exit 4: missing 4 octets
# Exit 5: no nmcli found
# Exit 6: all other errors

show_help(){
cat <<HelpMSG
==========================
Usage: sudo bash set-ip.sh IP INTERFACE

Prerequisites:
You must have nmcli installed
to install: yum install NetworkManager
==========================
HelpMSG
}
# Catch help calls, catch not sudo, catch no IP, catch no nic, catch no nmcli
[[ "$1" =~ -*h+ ]] && show_help && exit 0
[[ "$EUID" -ne 0 ]] && echo -e "Please run as sudo/root" && exit 6
[[ -z "$1" ]] && echo -e "Please enter an IP" && show_help && exit 4
[[ -z "$2" ]] && echo -e "Please supply an interface" && show_help && exit 6
[[ ! -f /usr/bin/nmcli ]] && echo -e "nmcli is not detected" && show_help && exit 5

get_route(){
        route=$(ip route | grep "default" | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
        echo -e "\t $route"

}

show_dns(){
    nmcli | grep -A6 "DNS configuration:"
}

# how to delete an IP
# sudo ip addr del 192.168.1.69/32 dev eth0
# Display some default information route/DNS
echo -e "Type --help for help"
echo -e "Default Router:"
get_route
show_dns
echo -e "***********************"

# check that the IP provided is actually an IP
if [[ "$1" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
then
        sudo nmcli con mod "$2" ipv4.addresses "$1"
        sudo nmcli con up "$2"
        sudo nmcli con mod "$2" autoconnect yes
        echo -e "\nPlease verify that your newly set static IP appears below:"
        nmcli | grep inet4
        sleep 3
else
        echo "The IP you provided was not valid, please try again."
        echo 4
fi
