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

sudo mkdir newcerts
sudo touch index.txt
sudo echo '01' | sudo tee serial

sudo openssl ca -config sign.cnf -out ${fqdn}.cert -infiles ${fqdn}.csr

cat ${fqdn}.key ${fqdn}.cert | sudo tee ${fqdn}.pem # use for mongod-tls
cat ${fqdn}.crt ca.crt | sudo tee ${fqdn}.bundle.crt  # use for https
