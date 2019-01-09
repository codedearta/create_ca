#!/bin/bash

fqdn=dearta.com

sudo rm -rf ./*

source gen_ca.sh
source gen_csr.sh
source sign.sh
