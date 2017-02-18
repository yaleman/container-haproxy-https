A playground for different methods of TLS load balancing.

There's a couple of ways to do this:

* Terminate SSL on the load balancer
* Terminate SSL on the web servers and use the load balancer to fling packets

The first one's easier for configuration, the second one can be more performant and tends to be easier to troubleshoot.

# Building the environment (work in progress)

2. `./rebuild.sh`, this does all the configuration of containers and builds configuration files.
	* Generates x509 certificates and keys, strips the passphrases and combines them into bundles
	* Creates a HAProxy configuration and confirms it's working
3. `./start.sh` will start the containers and expose the ports.

There's three services exposed:

* 8080 - this is a plaintext HTTP load balancer, for checking that the backend nodes are working.
* 8081 - HAProxy terminates SSL and forwards requests to the nginx servers over plaintext HTTP
* 8082 - HAProxy forwards connections to the HTTPS-enabled nginx servers, allowing them to terminate the HTTPS connection.