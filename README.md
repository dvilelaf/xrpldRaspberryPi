# Xrpld Raspberry Pi
A script to build and run ```xrpl``` (aka rippled) on a Raspberry Pi 4. Detailed instructions on how to build were taken from [here](https://xrpl.org/build-run-rippled-ubuntu.html).

</br>

## **WARNING**
**This is an experiment for educational purposes only. Keep in mind that running a production-grade XRPL node requires dedicated, professional hardware and expertise handling servers, updates and software in general, as well as time to take care of the node. This experiment is just an attempt to demonstrate the capabilities and efficiency of the XRP ledger, and a cheap and easy way of introducing yourself to how the XRPL works.**

</br>

## Using the script

Getting and building ```xrpl``` (aka rippled) yourself following the instructions [here](https://xrpl.org/build-run-rippled-ubuntu.html) is recommended over using this script, but if you are as lazy as me, just run the bash script from your Raspberry Pi. It will download and build xrpl on your home directory. Also, it will create a systemd service called ```rippled```.

You may have to configure the node parameters. Citing the official website:

1. Set the [node_db]'s path to the location where you want to store the ledger database.

2. Set the [database_path] to the location where you want to store other database data.

3. Set the [debug_logfile] to a path where rippled can write logging information.

Once this is done, the node will be running as a stock node (non-validating). You can use the following commands to  control it.

    sudo systemctl start rippled
    sudo systemctl stop rippled
    sudo systemctl restart rippled
    sudo systemctl status rippled

To get more info about the node's status:

    cd ~/rippled/build
    ./rippled server_state


## Configuring the node as a validator

In order to configure the node as a validator, you will need to run [validator-keys](https://github.com/ripple/validator-keys-tool/blob/master/doc/validator-keys-tool-guide.md) on your machine:

    ./validator-keys crete_keys

And copy the generated token at the end of your rippled.cfg, like this:

    [validator_token]
    <generated-token>

I've included a compiled copy of validator-keys in this repository just in case, but remember: **you should never trust the binaries of a stranger**.