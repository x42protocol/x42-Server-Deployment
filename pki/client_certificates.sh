#!/bin/bash
# @author Ovidiu Ionescu
# This script generates client certificates for browser authentication

if [ $# -lt 2 ]; then
  echo "Usage: $0 name email"
  exit 1
fi

NAME=$1
EMAIL=$2

# Generate self signed certificate. Run these lines manually when you need the generate the CA certificate
#openssl req -newkey rsa:4096 -keyout ca_org_key.pem -out ca_org_csr.pem -nodes -days 3650 -subj "/O=Organizator/CN=Organizator Root CA X3"
#openssl x509 -req -in ca_org_csr.pem -signkey ca_org_key.pem -out ca_org_cert.pem -days 3650

create_extension_file() {
cat << ENDOFTEXT > extension.cnf
[ v3_req ]
# Extensions to add to a certificate request when signing it
extendedKeyUsage = serverAuth, clientAuth, codeSigning, emailProtection
basicConstraints = CA:FALSE
keyUsage = critical, nonRepudiation, digitalSignature, keyEncipherment
nsCertType = client,email
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
subjectAltName = email:${EMAIL}
ENDOFTEXT

}
# create a certificate based on the CA
openssl req -newkey rsa:4096 -keyout ${NAME}_key.pem -out ${NAME}_csr.pem -nodes -days 365 -subj "/CN=${NAME}"
# we add the extensions manually, some bug in openssl prevents them from being copied from the request
create_extension_file
openssl x509 -req -in ${NAME}_csr.pem -CA ca_org_cert.pem -CAkey ca_org_key.pem -out ${NAME}_cert.pem -set_serial 01 -days 365 -extensions v3_req -extfile extension.cnf

openssl verify -CAfile=ca_org_cert.pem ${NAME}_cert.pem

# package the certificate and the password
openssl pkcs12 -export -clcerts -in ${NAME}_cert.pem -inkey ${NAME}_key.pem -out ${NAME}.p12
