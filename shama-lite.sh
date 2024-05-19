#!/bin/bash

# Hello!
# This is a simple/minimal script to fetch some basic information about your system
# I made this for my own personal use
# It is limited as you can see
# It's my own take on neofetch but less flashy and less fancy lol
# I understand that my code isn't 5* quality, so yeah ...
# I only tested it on Kali and Ubuntu 
# On other distros some commands won't work
# So please feel free to change whatever command
# Does not work with the appropriate one for your system.

# Colors
grey="\033[0;37m"
purple="\033[0;35m"
red="\033[1;31m"
green="\033[1;32m"
yellow="\033[1;33m"
transparent="\e[0m"

# Commands & Variables

# OS
os="$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '\"')"

# CPU info
cpu="$(awk -F: '/model name/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}' /proc/cpuinfo)"

# RAM info
ram_kb=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
ram=$((ram_kb / 1024)) # Convert from kB to MB

# Hostname
host=$(cat /proc/sys/kernel/hostname)

# Number of packages installed (Debian-based)
if command -v dpkg &> /dev/null; then
  pkgs=$(dpkg --get-selections | wc -l)
else
  pkgs="N/A"
fi

# Uptime
up=$(awk '{d=$1/86400; h=($1%86400)/3600; m=($1%3600)/60; printf "%dd, %dh, %dm\n", d, h, m}' /proc/uptime)

# GPU info
gpu=$(lspci | grep VGA | cut -d ':' -f 3 | cut -d '[' -f 1 | sed 's/^ *//')

# Main function
display_info() {
  echo -e "            ${green}——-${purple}SH${red}.${purple}AMA${green}-——"   
  echo -e ""    
  echo -e "      ${green}|${purple}■${grey} OS     ${red}: ${grey} ${os^^}"
  echo -e "      ${purple}|${green}■${grey} UP     ${red}: ${grey} ${up}"
  echo -e "      ${green}|${purple}■${grey} CPU    ${red}: ${grey} ${cpu^^}"
  echo -e "      ${green}|${purple}■${grey} GPU    ${red}: ${grey} ${gpu}"
  echo -e "      ${purple}|${green}■${grey} RAM    ${red}: ${grey} ${ram}MB"
  echo -e "      ${green}|${purple}■${grey} HOST   ${red}: ${grey} ${host^^}"
  echo -e "      ${purple}|${green}■${grey} PKGS   ${red}: ${grey} ${pkgs}"
  echo -e ""
}

# Logo
echo -e ""
echo -e "               |\_/|"
echo -e "               '"$yellow"o"$transparent"."$yellow"o"$transparent"'"
echo -e "               > ^ <"

# Main function init
display_info
