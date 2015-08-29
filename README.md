BitcoinXT for Docker
===================

Docker image that runs a bitcoinxt node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/vultrbitcoinxt), [Digital Ocean](http://bit.ly/dobitcoinxt), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 40 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on [Vultr 1024 MB RAM/320 GB disk instance @ $8/mo](http://bit.ly/vultrbitcoinxt).  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.

If you'd like to try out a few things use this [Digital Ocean](http://bit.ly/dobitcoinxt) link to get $10 free credits.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/keo/docker-bitcoinxt/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `bitcoinxt-data` volume to persist the bitcoinxt blockchain data, should exit immediately.  The `bitcoinxt-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker run --name=bitcoinxt-data -v /bitcoin busybox chown 1000:1000 /bitcoin
        docker run --volumes-from=bitcoinxt-data --name=bitcoinxt-node -d \
            -p 8333:8333 \
            -p 127.0.0.1:8332:8332 \
            keo604/bitcoinxt

2. Verify that the container is running and bitcoinxt node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        keo604/bitcoinxt:latest     "btc_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:8332->8332/tcp, 0.0.0.0:8333->8333/tcp   bitcoinxt-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f bitcoinxt-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).

Credits
-------

Original work by Kyle Manna [https://github.com/kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind).
Modified to use Bitcoin XT instead of Bitcoin Core.

