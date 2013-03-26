###
### Slackware setup
###

This set of instructions and scripts is designed to set up Slackware64 system as
fast as possible with as little manual work as possible.

Conceptually it goes like this:
-------------------------------
1a. Boot, get networking up and start SSH server
1b. Get away from physical machine and SSH into the machine from elsewhere
    (common tasks, but not easily scripted)

2.  Setup variables that will be used throughout automated installation process

3a. Setup partitions and mounts:
    - server instance dependent
    - may be done manually if specialized configuration is desired
    - you can also use a script for setting it up (creates 4G swap, 20G root and rest in /var on /dev/sda)
3b. Execute out-of-chroot-to-new-root installation script

4.  In-chroot installation script gets executed by script from previous step

5.  Set root password

6.  Reboot



Actually, you should:
---------------------
Open file in this directory that starts with "01-..." and follow the instructions.
If file extension is:
- .txt: instructions should be followed manually, because they are hardware-dependent
- .sh: it is an automated procedure, contents can be copy-pasted into the SSH console
