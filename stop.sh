#!/bin/bash
echo "Targeting the following nodes:"
docker ps -f name=haproxy-simple-

echo ""
echo "Stopping now..."
docker ps -qa -f name=haproxy-simple- | xargs docker rm -f
echo "Done."
