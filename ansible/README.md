# Ansible Code

The Ansible code that will be used in order to install the required services.

There is one configuarion for clients to use (in the client folder) and one for the server to use (in the server folder). Inside each folder there will be all of the playbooks that are running in the background.

Installs the following services:
1. cloudflared service (on the server) - To connect a Tunnel to the whole subnet
2. docker (on the server and client) - To pull and use Docker images

After the services are installed, the docker-compose.yml is being pulled from the repo to start the services along with the required configurations.
If you fork the repository you can put your own Dashboard and it will load up (keep in mind to delete the **UID** from the Prometheus Datasource to ensure it grabs the right one)