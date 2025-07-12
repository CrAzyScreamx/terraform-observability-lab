# Terraform Observability Lab

A project made by me to learn the basics of Terraform.

The project uses two main providers:
1. Azure - Using azurerm to provision Resource Group, Subnet, NICs for the servers, etc.
2. Cloudflare - Using cloudflare to create a ZTNA Tunnel in order to gain Private Access without publishing the Servers to the world (WOPA client required)

The project creates the following:
1. Server - The main server that holds cloudflared service, Grafana, and Prometheus.
2. Clients - The environment that the Server will collect metrics from and display on Grafana automatically, as more clients being added, more IPs the Grafana will be able to monitor.

After both Server and Clients are connected, it uses custom_data feature to upload an initital script, this scripts pulls Ansible configuration and installs all of the required components in order for the services to load up.