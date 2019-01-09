fqdn=dearta.com

sudo rm -rf ca.key ca.cnf

echo "
[req]
default_bits = 2048
default_keyfile = ca.key 
encrypt_key = no
default_md = sha512
prompt = no
utf8 = yes
distinguished_name = dn
x509_extensions = my_extensions

[dn]
C = UK
ST = England
L = London
O  = Dearta
CN = ${fqdn}

[my_extensions]
basicConstraints = CA:TRUE
subjectKeyIdentifier = hash" | sudo tee ca.cnf


sudo openssl req -x509 -newkey rsa:2048 -config ca.cnf -out ca.cert

sudo openssl req -text -noout -in ca.cert
