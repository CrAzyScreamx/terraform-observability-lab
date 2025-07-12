# Terraform Code

The Terraform code has the following structure:
1. keys - A directory that holds the private keys of each machine (client or server) after they're created
2. modules - Custom modules I added to provide more readability in Terraform
3. scripts - The script that helps me initialize terraform with pre-defined configuarions (like backend, some variables, etc.), in order to use you can put a .env inside that folder and provide all of the secrets it needs.
4. setupFiles - Files that are being sent to Clients/Server after they're created using custom_data and templateFile in Azure
5. cloudflare.tf - Creates the Cloudflare resources in your account automatically, only thing needed is to add the auto-created Policy to Device Enrollment (Under settings --> WARP Client --> Device Enrollment), it is set to "Everyone" so be careful. For more instructions, you can refer to Cloudflare on how to install and connect the WARP Client
6. main.tf - Holds the main configuration for Azure, creating the required resources for the environment to operate
7. outputs.tf - Outputs the clients and server ips.
8. terraform.tfvars - Some basic terraform variables

## Variables
The code accepts the following variables:

1. environment_name - Specifies the Environment name, if using .debug-dev.sh it'll be configured automatically
2. application_name - Specifies the Application name, if using .debug-dev.sh it'll be configured automatically
3. azure_location - Specifies the location you want Azure to provision the resources
4. vnet_address_space (optional) - The Address spaces you want for Azure, default is "israelcentral"
5. client_count (optional) - The amount of clients you want to add, default is "1"
6. cloudflare_account_id (Required if using cloudflare) - The account ID for cloudflare to connect to
7. cloudflare_configuration (optional) - If you want to use cloudflare or not, default is "false"
8. grafana_admin_user (optional) - The Admin username to set to grafana, default is "admin"
9. grafana_admin_password - The Admin password to set to grafana
10. node_exporter_port (optional) - The port to use in node_exporter (the service prometheus will use to get metrics from its clients), default is "9100"