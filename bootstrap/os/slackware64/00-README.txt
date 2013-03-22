###
### Slackware setup
###

This set of instructions and scripts is designed to set up Slackware64 system as
fast as possible with as little manual work as possible.

Conceptually it goes like this:
1. Boot, get networking up and start SSH server (common, but not easily scripted)
2. Login, setup partitions and mounts (server instance dependent)
3. Execute installation scripts from certain URI (again common)

fstab, lilo.conf, lilo write MBR, reboot
