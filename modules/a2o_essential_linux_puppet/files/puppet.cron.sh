#!/bin/bash

sleep `expr $RANDOM % 60`
/usr/local/puppet/bin/puppet agent --test
