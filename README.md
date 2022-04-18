# x42-Server-Deployment

Copy all files to server.
Navigate to the "build" folder
Execute the docker-build command for each (xcore, xserver, xserverui)
Todo: Register a Dockerhub Account for x42.  All images will be tagged with each release.
      No Building instructions will be required for deployments.

Navigate to the "config" folder, and set all the configuration files as per your environment

Todo: Detailed Configuration requirements to be documented
	  .env file to hold all environment specific configurations, rest are going to be based on $Variables

run "docker-compose up -d" to start the xserver


Ideal installation:
1) run ./setup.sh 
2) configure .env file based on example
3) ansible-playbook ansible/x42docker.yaml