#!/bin/bash

echo "Starting nginx containers..."
docker run -d -p 8000:80 --name haproxy-https-nginx-1 -v $(pwd)/www/1:/usr/share/nginx/html:ro nginx
docker run -d -p 8001:80 --name haproxy-https-nginx-2 -v $(pwd)/www/2:/usr/share/nginx/html:ro nginx
echo "Done."

echo "Starting HAProxy"
docker run -d -p 8080:8080 --name haproxy-https-haproxy haproxy-https 
echo "Done."
