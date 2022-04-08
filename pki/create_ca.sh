# Generate self signed certificate. Run these lines manually when you need the generate the CA certificate
openssl req -newkey rsa:4096 -keyout ca_org_key.pem -out ca_org_csr.pem -nodes -days 3650 -subj "/O=x42Server/CN=X42Server Root CA X3"
openssl x509 -req -in ca_org_csr.pem -signkey ca_org_key.pem -out ca_org_cert.pem -days 3650

