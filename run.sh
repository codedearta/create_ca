#!/bin/bash

fqdn=dearta.com

sudo rm -rf *.cnf *.cert *.key *.csr newcerts index.txt serial

source gen_ca.sh
source gen_csr.sh
source sign.sh
