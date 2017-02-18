A playground for different methods of TLS load balancing.

There's a couple of ways to do this:

* Terminate SSL on the load balancer
* Terminate SSL on the web servers and use the load balancer to fling packets

The first one's easier for configuration, the second one can be more performant and tends to be easier to troubleshoot.

# Building the environment (work in progress)

1. Run `./gen_certs.sh`, this will create a pair of x509 certificates and keys in the `ssl/` folder.
