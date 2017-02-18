#!/bin/bash

echo "Stopping..."
./stop.sh
echo "Done."


echo "Generating HAproxy configuration."
egrep -v "^server" haproxy.cfg.default > haproxy.cfg
echo "server server1 $(cat docker_ip.cfg):8000 maxconn 32 check inter 1s rise 1 fall 1" >> haproxy.cfg
echo "server server2 $(cat docker_ip.cfg):8001 maxconn 32 check inter 1s rise 1 fall 1" >> haproxy.cfg
echo "Done."

echo "Rebuilding haproxy-https..."
docker build -t haproxy-https .


echo ""
echo "Checking configuration..."
docker run -it --rm --name haproxy-syntax-check haproxy-https haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg

echo ""
echo "Done."
