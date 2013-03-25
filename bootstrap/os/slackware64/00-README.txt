###
### Slackware setup
###

This set of instructions and scripts is designed to set up Slackware64 system as
fast as possible with as little manual work as possible.

Conceptually it goes like this:
1. Boot, get networking up and start SSH server, logout and SSH into the machine
    (common tasks, but not easily scripted)
2. Setup partitions and mounts:
    - server instance dependent
    - you can use a script for 4Gswap-20Groot-RESTvar
    - may be done manually if specialized configuration is desired
3. Setup variables that will be used throughout automated installation process
4. Execute installation script
