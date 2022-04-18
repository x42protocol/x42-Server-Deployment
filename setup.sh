#!/bin/sh

apt update -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y

ansible-playbook -i ansible/x42docker.yaml
ansible-playbook -i ansible/x42xserver.yaml