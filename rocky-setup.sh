#!/usr/bin/env bash
# Installation and setup for Rocky Linux home lab VMs

sudo dnf update -y
sudo dnf install git -y
sudo dnf install curl -y
sudo dnf install wget -y

wget https://raw.githubusercontent.com/Hexadecimalz/Bash-Scripts/main/set-ip.sh

sudo dnf install epel-release -y



