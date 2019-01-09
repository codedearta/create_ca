#!/bin/bash

echo "[req]
default_bits = 2048
default_keyfile = ${fqdn}.key 
encrypt_key = no
default_md = sha512
prompt = no
utf8 = yes
distinguished_name = dn
req_extensions = my_extensions

[dn]
C = UK
ST = England
L = London
O  = Dearta
CN = ${fqdn}

[my_extensions]
basicConstraints= CA:FALSE
subjectAltName= @san
subjectKeyIdentifier = hash

[san]
DNS.1 = ${fqdn}
DNS.2 = opsman1.${fqdn}
DNS.3 = opsman2.${fqdn}
DNS.4 = opsman3.${fqdn}" | sudo tee ${fqdn}.cnf

sudo openssl req -newkey rsa:2048 -config ${fqdn}.cnf -out ${fqdn}.csr

sudo openssl req -text -noout -in ${fqdn}.csr
