#!/bin/bash
./stop.sh

echo "Starting nginx containers..."
docker run -d -p 8000:80 -p 8010:443 --name haproxy-https-nginx-1 -v $(pwd)/www/1:/usr/share/nginx/html:ro nginx
docker run -d -p 8001:80 -p 8011:443 --name haproxy-https-nginx-2 -v $(pwd)/www/2:/usr/share/nginx/html:ro nginx
echo "Done."

echo "Starting HAProxy"
docker run -d -p 8080:8080 -p 8081:8081 -p 8082:8082 --name haproxy-https-haproxy -v $(pwd)/ssl/certHA:/etc/ssl:ro -v $(pwd)/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy
echo "Done."
