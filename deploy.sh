#!/bin/bash

echo "Copying config files"
sudo cp -R conf.d/   /etc/nginx

echo "Copying snippets"
sudo cp -R snippets/ /etc/nginx

echo "Copying proxy paramters"
sudo cp -R params/   /etc/nginx

echo "Checking for Diffie-Hellman parameters files"

if ! [ -f "/etc/ssl/certs/ffdhe2048.pem" ]; then
  echo "2048-bit DH parameters file does not exist."

  echo "Copying file from dhparam/ffdhe2048.pem to /etc/ssl/certs/ffdhe2048.pem"
  cp ./dhparam/ffdhe2048.pem /etc/ssl/certs/ffdhe2048.pem
else
  echo "2048-bit DH parameters file already exists."
fi

if ! [ -f "/etc/ssl/certs/ffdhe4096.pem" ]; then
  echo "4096-bit DH parameters file does not exist."

  echo "Copying file from dhparam/ffdhe4096.pem to /etc/ssl/certs/ffdhe4096.pem"
  cp ./dhparam/ffdhe4096.pem /etc/ssl/certs/ffdhe4096.pem
else
  echo "4096-bit DH parameters file already exists."
fi

echo "Validating configuration"
sudo nginx -t

echo "You must reload nginx for the settings to take effect."
