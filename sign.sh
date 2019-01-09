fqdn=dearta.com
openssl x509 -req -sha512 -in ${fqdn}.csr -CA ca.cert -CAkey ca.key -CAcreateserial -out ${fqdn}.cert
sudo openssl x509 -text -noout -in ${fqdn}.cert
cat ${fqdn}.key ${fqdn}.cert | sudo tee ${fqdn}.pem # use for mongod-tls

cat ${fqdn}.crt ca.crt | sudo tee ${fqdn}.bundle.crt  # use for https
sudo openssl x509 -text -noout -in ${fqdn}.bundle.cert
