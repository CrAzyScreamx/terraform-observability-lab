# Terraform Observability Lab

A project made by me to learn the basics of Terraform.

The project uses two main providers:
1. Azure - Using azurerm to provision Resource Group, Subnet, NICs for the servers, etc.
2. Cloudflare - Using cloudflare to create a ZTNA Tunnel in order to gain Private Access without publishing the Servers to the world (WOPA client required)

The project creates the following:
1. Server - The main server that holds cloudflared service, Grafana, and Prometheus.
2. Clients - The environment that the Server will collect metrics from and display on Grafana automatically, as more clients being added, more IPs the Grafana will be able to monitor.

After both Server and Clients are connected, it uses custom_data feature to upload an initital script, this scripts pulls Ansible configuration and installs all of the required components in order for the services to load up.

## How to run

If you want to use the script in terraform/scripts/.debug-dev.sh you must create a .env file in the scripts folder with the following:
* SUBSCRIPTION_ID - The Subscrpition ID for Azure
* APPLICATION_NAME - The name of the application
* ENVIRONMENT_NAME - The name of the environment
* BACKEND_RG_NAME - The Resource Group used that holds the Backend container
* BACKEND_STORAGE_ACCOUNT_NAME - The Storage Account that holds the backend container
* BACKEND_CONTAINER_NAME - The Container name that holds your tfstate file securely
* CLOUDFLARE_API_TOKEN - The token to use from Cloudflare
* CLOUDFLARE_ACCOUNT_ID - The account ID to use from Cloudflare

Run the following command in a bash Terminal:
```bash
./scripts/.debug-dev.sh apply
```
This will start the script like any normal environment, after approving, it'll create the infrastructure.

## Exposed Ports

Port 3000 - Exposed for Grafana to access: ```http://<SERVER_IP>:3000```

If you configure rules to stop access to other clients make sure the following ports stay open:
1. Server --> Client:9100 - Client listens on port 9100 (or any port you give in the node_export var), so you must allow it

That's all, apart from this, anything else between both machines can be denied