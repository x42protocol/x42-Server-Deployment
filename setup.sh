#!/bin/sh

apt update
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y

ansible-playbook -i ansible/x42docker.yaml
ansible-playbook -i ansible/x42xserver.yaml