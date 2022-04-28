#!/bin/bash
# @author Ovidiu Ionescu
# This script generates client certificates for browser authentication

if [ $# -lt 3 ]; then
  echo "Usage: $0 name password email"
  exit 1
fi

NAME=$1
PASSWORD=$2
EMAIL=$3

create_extension_file() {
cat << ENDOFTEXT > pki/extension.cnf
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

mkdir -p pki/${NAME}
openssl req -newkey rsa:4096 -keyout pki/${NAME}/${NAME}_key.pem -out pki/${NAME}/${NAME}_csr.pem -nodes -days 365 -subj "/CN=${NAME}"
# we add the extensions manually, some bug in openssl prevents them from being copied from the request
create_extension_file
openssl x509 -req -in pki/${NAME}/${NAME}_csr.pem -CA pki/ca_org_cert.pem -CAkey pki/ca_org_key.pem -out pki/${NAME}/${NAME}_cert.pem -set_serial 01 -days 365 -extensions v3_req -extfile pki/extension.cnf

openssl verify -CAfile=pki/ca_org_cert.pem pki/${NAME}/${NAME}_cert.pem

# package the certificate and the password
openssl pkcs12 -export -clcerts -in pki/${NAME}/${NAME}_cert.pem -inkey pki/${NAME}/${NAME}_key.pem -out pki/${NAME}/${NAME}.p12  -passout pass:${PASSWORD}
