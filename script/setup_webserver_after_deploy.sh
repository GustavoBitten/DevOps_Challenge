#! /bin/bash
sudo apt-get update
sudo apt install nginx -y
sudo systemctl start nginx
if [ ! -e /var/run/nginx.pid ]; then
    exit 127
fi
sudo chmod o+r /var/log/nginx/access.log
exit 0