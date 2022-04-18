#!/bin/sh

apt update -y
apt install software-properties-common -y
add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y

ansible-playbook ansible/x42docker.yaml
ansible-playbook ansible/x42xserver.yaml