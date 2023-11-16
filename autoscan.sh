#!/bin/bash

#Colours
green_colour="\e[0;32m\033[1m"
end_colour="\033[0m\e[0m"
red_colour="\e[0;31m\033[1m"
blue_colour="\e[0;34m\033[1m"
yellow_colour="\e[0;33m\033[1m"
purple_clour="\e[0;35m\033[1m"
turquoise_colour="\e[0;36m\033[1m"
gray_colour="\e[0;37m\033[1m"

input(){

       	echo -ne "${green_colour}[~] IP: ${end_colour}"
       	read -r ip_address

	sleep 0.5

	echo -e "\n\t ${green_colour}[~] Starting port scan${end_colour}\n"

	sleep 0.5

	port_scan="nmap -p- -sS -vvv -Pn -n --open --min-rate 5000 $ip_address -oG allPorts"
	eval "$port_scan"

	open_ports=$(cat allPorts | grep -oP '\d{1,5}/open' | cut -d "/" -f 1 | xargs | tr ' ' ',')

	echo -e "\n\t${green_colour}[~] Starting service scan${end_colour}\n"

	sleep 0.5

	service_scan="nmap -sCV -p${open_ports} --min-rate 5000 $ip_address -oN targeted"
	eval "$service_scan"
}

input
