fqdn=dearta.com

echo "
[ca]
default_ca = my_ca

[my_ca]
serial = ./serial
database = ./index.txt
new_certs_dir = ./newcerts
certificate = ./ca.cert
private_key = ./ca.key
default_md = sha512
default_days = 365
policy = my_policy

[my_policy]
countryName = optional
stateOrProvinceName = optional
organizationName = optional
organizationalUnitName = optional
commonName = supplied" | sudo tee sign.cnf

echo "
basicConstraints=CA:FALSE
subjectAltName=@san
subjectKeyIdentifier = hash

[san]
DNS.1 = ${fqdn}
DNS.2 = www.${fqdn}
DNS.3 = dearta.ch
DNS.4 = www.dearta.ch
DNS.5 = dearta.co.uk
DNS.6 = www.dearta.co.uk
DNS.7 = dearta.london
DNS.8 = www.dearta.london" | sudo tee ext.sign.cnf

sudo rm -rf newcerts
sudo rm -rf index.txt
sudo mkdir newcerts
sudo touch index.txt
sudo echo '01' | sudo tee serial

sudo openssl ca -config sign.cnf -extfile ext.sign.cnf -out ${fqdn}.cert -infiles ${fqdn}.csr

cat ${fqdn}.key ${fqdn}.cert | sudo tee ${fqdn}.pem # use for mongod-tls
cat ${fqdn}.cert ca.cert | sudo tee ${fqdn}.bundle.cert  # use for https
