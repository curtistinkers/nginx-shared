#!/bin/bash

echo "Copying configuration files"
cp -R conf.d/   /etc/nginx
cp -R snippets/ /etc/nginx
cp -R params/   /etc/nginx

echo "Reloading nginx.service"
systemctl reload nginx.service
