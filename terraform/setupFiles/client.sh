#! /bin/bash

apt update
apt install -y software-properties-common git
apt-add-repository --yes --update ppa:ansible/ansible || true
apt install -y ansible dos2unix

ssh-keyscan github.com >> ~/.ssh/known_hosts

ansible-pull -U git@github.com:CrAzyScreamx/terraform-observability-lab.git ansible/client/main_playbook.yml --directory=/opt/bootstrap/ansible --checkout=main -i localhost \
--extra-vars "node_exporter_port=${node_exporter_port}"