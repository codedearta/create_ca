fqdn=dearta.com

sudo rm -rf ${fqdn}.csr ${fqdn}.key ${fqdn}.cnf

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
DNS.2 = www.${fqdn}
DNS.3 = dearta.ch
DNS.4 = www.dearta.ch
DNS.5 = dearta.co.uk
DNS.6 = www.dearta.co.uk
DNS.7 = dearta.london
DNS.8 = www.dearta.london" | sudo tee ${fqdn}.cnf

sudo openssl req -newkey rsa:2048 -config ${fqdn}.cnf -out ${fqdn}.csr

sudo openssl req -text -noout -in ${fqdn}.csr
