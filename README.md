# NGINX config files

A collection of example application site configs and snippets for running an NGINX server.

## Folders

- `conf.d/`  
  Server-wide configuration files
- `params/`  
  Proxy parameters
- `snippets/`  
  Common code snippets to be included in other files

## How to use

### Download Diffie-Hellman parameter

Use the follwoing command to download the Diffie-Hellman parameter for TLS 1.2:

```sh
curl https://ssl-config.mozilla.org/ffdhe2048.txt > /etc/ssl/certs/dhparam.pem
```

We use a common DH param per: https://github.com/mozilla/ssl-config-generator/issues/60#issuecomment-531522838


### Install NGINX

#### Add apt-cache proxy (optional)

```sh
echo 'Acquire::http { Proxy "http://apt-proxy.svcs.hjem.cloud:3142/"; }' \
    | sudo tee /etc/apt/apt.conf.d/00aptproxy
sudo apt-get update
```

#### Add official NGINX repository

The setup instruction on the NGINX website say to use HTTPS to connect to the repository, but apt-cacher-ng requires HTTP for package caching to work as expected.

```sh
# Install prerequisites using apt
sudo apt install -y curl gnupg ca-certificates

# Download the signing key
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx.gpg > /dev/null

# Add repository to apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nginx.gpg] \
    http://nginx.org/packages/$(. /etc/os-release && echo "$ID") \
    $(. /etc/os-release && echo "$VERSION_CODENAME") nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list > /dev/null

# Pin package to official release
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx > /dev/null

# Update apt and install NGINX
sudo apt update
sudo apt install -y nginx

# Create a sites enabled folder
mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled

```

