#! /bin/bash

apt update
apt install -y software-properties-common git
apt-add-repository --yes --update ppa:ansible/ansible || true
apt install -y ansible dos2unix


mkdir -p /opt/bootstrap
cd /opt/bootstrap
echo "New"
echo "${github_key}" | base64 -d > /opt/bootstrap/github.key
chmod 600 /opt/bootstrap/github.key

dos2unix /opt/bootstrap/github.key

cat << 'EOF' >> ~/.ssh/config
Host github.com
  HostName github.com
  User git
  IdentityFile /opt/bootstrap/github.key
  IdentitiesOnly yes
EOF

ssh-keyscan github.com >> ~/.ssh/known_hosts

export targets=${client_private_ips}

ansible-pull -U git@github.com:CrAzyScreamx/terraform-observability-lab.git ansible/server/main_playbook.yml --directory=/opt/bootstrap/ansible --checkout=main -i localhost \
--extra-vars "cloudflare=${cloudflare} tunnel_token=${tunnel_token} grafana_user=${grafana_username} grafana_password=${grafana_password} app_name=${applicaton_name} node_exporter_port=${node_exporter_port}"

