#!/bin/bash

# CHECK PERIODIC run this script to update root.hints file, then commit
wget -O root.hints http://www.internic.net/zones/named.root
