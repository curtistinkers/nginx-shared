#!/bin/bash

echo "Copying configuration files"
sudo cp -R conf.d/   /etc/nginx
sudo cp -R snippets/ /etc/nginx
sudo cp -R params/   /etc/nginx

echo "Validating configuration"
sudo nginx -t

echo "You must reload nginx for the settings to take effect."
