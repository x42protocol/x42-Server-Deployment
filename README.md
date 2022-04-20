# x42-Server-Deployment

Preparing the Server for installation of xServer

`git clone https://github.com/x42protocol/x42-Server-Deployment`

`cd x42-Server-Deployment`

`sh setup.sh`


**Installing Traefik Reverse Proxy**

`cd traefik`

`sh create_ca.sh`

`sh client_certificates.sh <Your Name> <your@email.com>` eg: sh client_certificates.sh satoshi satoshi@nakamoto.com

`docker-compose up -d`


Note: To view the logs, execute: 
`docker-compose logs`
within the traefik folder.
Please notice if there are any errors, and take corrective actions.

Download the file:`pki/<Your Name>/YourName.p12` to your Client Workstation. eg: Your laptop.

**Import the YourName.p12 file to your Chrome browser**
Guide: 
https://www.digicert.com/kb/managing-client-certificates.htm

Note: You will the specified Client Workstation (eg: Laptop) which has the certificate installed to access the XServer.
Without the client certificate, access will be denied.

**xServer Setup and Installation:**

`cd ../`

`cd xserver/`


**Configuration Files:**

`xserver/xcore/x42Main/x42.conf`

`xserver/xserver/xServer.conf`

`xserver/xserverui/app.config.json`

`xserver/.env`

Mandatory configuration changes required:

1) You are required to configure 4 subdomains on your DNS Provider.
   * x42server
   * x42serverpub
   * x42core
   * x42serverui

2) Configure the `xserver/.env` file:
   Domain setup:
   `XSERVER_BACKEND`: Specify the URL for your x42server. eg: `x42server.yourdomain.com`
   
   `XSERVERPUBLIC_BACKEND`: Specify the public url for your xserver.  eg: `x42serverpub.yourdomain.com`
   
   `XCORE_BACKEND`: Specify the x42core url for your xcore server eg: `x42core.yourdomain.com`
   
   `XSERVER_FRONTEND`: specify the url which you will access the user interface for the x42 server.  eg: `x42serverui.yourdomain.com`

   **Database credentials:**
   `POSTGRES_USER=postgres
   POSTGRES_PASSWORD: Specify a complex password.
   POSTGRES_DB=x42`

3) Configure your xServer `xserver/xserver/xServer.conf`
   Modify the `connectionstring` as you had configured it in your .env file
   `connectionstring=User ID=postgres;Password=<your postgres password>;Host=x42postgres;Port=5432;Database=x42;`

4) Configure your xCore if required. `xserver/xcore/x42Main/x42.conf`
   Typically you don't change anything.
   Note that upon server startup, the xcore blockchain files will be stored here, including your WALLET file.

5) Configure `xserver/xserverui/app.config.json`

   `{
       "fullNodeEndpoint": "https://x42core.yourdomain.com/api", #subdomain and domain must match XCORE_BACKEND in the .evn file
       "xServerEndpoint": "https://x42server.yourdomain.com" #subdomain and domain must match XSERVER_BACKEND in the .env file
   }`

6) **Startup xServer**
   `docker-compose up -d`

   You may verify logs with `docker-compose logs`
