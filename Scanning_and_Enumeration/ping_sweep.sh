#!/bin/bash

check_host_alive_ping()
{
	#echo "checking host with ping 192.168.59.$i"
	ping -c 1 -W 2 192.168.59.$i > /dev/null
        #fping -u -t 100 192.168.59.$i > /dev/null 
	#nmap -sU 192.168.59.$i | grep -q "Host is up" > /dev/null	
	[ $? -eq 0 ] && echo "192.168.59.$i" 
}

check_host_alive_nmap(){
	#nmap -sU 192.168.59.$i | grep -q "Host is up" > /dev/null 
	fping -u -t 100 192.168.59.$i > /dev/null
	[ $? -eq 0 ] && echo "192.168.59.$i"

}

ips=($(for i in {1..254}; do (check_host_alive_ping 192.168.59.$i); done))

ips+=($(for i in {1..254}; do (check_host_alive_nmap 192.168.59.$i); done))

#for i in "${ips[@]}"; do (echo $i); done


sorted_unique_ips=($(echo "${ips[@]}" | tr ' ' '\n'| sort -u | tr '\n' ' '))


check_host_port(){
 echo "nc -nvz $1"
 nc −nvz $1 1−100 > $1.txt 2>&1
 cat $1.txt
 rm −rf \$1.txt
}


for i in "${sorted_unique_ips[@]}"; do ( echo "$i" >> ping_sweep_output.txt); done
