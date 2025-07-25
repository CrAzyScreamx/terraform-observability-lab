#! /bin/bash

apt update
apt install -y software-properties-common git
apt-add-repository --yes --update ppa:ansible/ansible || true
apt install -y ansible dos2unix jq


mkdir -p /opt/bootstrap
cd /opt/bootstrap

ssh-keyscan github.com >> ~/.ssh/known_hosts

client_private_ips_json='${client_private_ips}'
SERVER_IP=$(hostname -I | awk '{print $1}')

export targets=$(echo "$client_private_ips_json" | jq -c ". + [\"$SERVER_IP:${node_exporter_port}\"]")

ansible-pull -U git@github.com:CrAzyScreamx/terraform-observability-lab.git ansible/server/main_playbook.yml --directory=/opt/bootstrap/ansible --checkout=main -i localhost \
--extra-vars "cloudflare=${cloudflare} tunnel_token=${tunnel_token} grafana_user=${grafana_username} grafana_password=${grafana_password} app_name=${applicaton_name} node_exporter_port=${node_exporter_port}"

