#!/bin/bash

rm ssl/*

# information on how SANs work - http://blog.endpoint.com/2014/10/openssl-csr-with-alternative-names-one.html

cat > openssl.cfg <<-EOF
[ req ]
prompt = no
output_password=example
default_bits=2048
distinguished_name = req_distinguished_name
extensions  = req_ext
req_extensions = req_ext

[ req_ext ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[ req_distinguished_name ]
C = AU
ST = Queensland
localityName = Town
O = Example Corp
OU = OrgUnit
CN = example.com
emailAddress=example@example.com

[alt_names]
DNS.1   = example.com
IP.1 =$(cat docker_ip.cfg)
EOF

echo "Generating Certificate 1.."
openssl req -newkey rsa:2048 -extensions req_ext -keyout ssl/cert1.key -x509 -config openssl.cfg  -outform PEM -out ssl/cert1.pem

echo "Checking cert details..."
openssl x509 -text -noout -in ssl/cert1.pem | egrep "(example|Key)"


echo "Generating Certificate 2.."
openssl req -newkey rsa:2048 -extensions req_ext -keyout ssl/cert2.key -x509 -config openssl.cfg -outform PEM -out ssl/cert2.pem

echo "Checking cert details..."
openssl x509 -text -noout -in ssl/cert2.pem | egrep "(example|Key)"


echo "Deleting openssl config"
rm openssl.cfg
