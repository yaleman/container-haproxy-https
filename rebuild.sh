#!/bin/bash

echo "Stopping..."
./stop.sh
echo "Done."


./gen_certs.sh

HAPROXYFILE="haproxy/haproxy.cfg"
rm $HAPROXYFILE

echo "Generating HAproxy configuration."
cat > $HAPROXYFILE <<-EOF
$(egrep -v "^server" haproxy/haproxy.cfg.default | egrep -v "^backend")

backend servers
    server server1 $(cat docker_ip.cfg):8000 maxconn 32 check inter 1s rise 1 fall 1
    server server2 $(cat docker_ip.cfg):8001 maxconn 32 check inter 1s rise 1 fall 1

backend servershttps
    server server1 $(cat docker_ip.cfg):8000 maxconn 32 check inter 1s rise 1 fall 1
    server server2 $(cat docker_ip.cfg):8001 maxconn 32 check inter 1s rise 1 fall 1

EOF

echo "Done generating HAProxy configuration."

echo ""
echo "Checking HAProxy configuration..."

RUNCMD="docker run -it --rm --name haproxy-https-haproxy -v $(pwd)/ssl/certHA:/etc/ssl:ro -v $(pwd)/haproxy/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg haproxy"

echo "SSL Cert list on HAproxy"

CMD="find /etc/ssl/"
$RUNCMD $CMD

echo "Testing configuration..."
CMD="haproxy -c -f /usr/local/etc/haproxy/haproxy.cfg"
$RUNCMD $CMD

echo ""
echo "Done."
