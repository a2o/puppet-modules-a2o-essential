#!/bin/bash

sleep `expr $RANDOM % 60`
/usr/local/puppet-sys/bin/puppet agent --test
