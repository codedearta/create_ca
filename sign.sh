fqdn=dearta.com
openssl x509 -req -in ${fqdn}.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out ${fqdn}.crt
