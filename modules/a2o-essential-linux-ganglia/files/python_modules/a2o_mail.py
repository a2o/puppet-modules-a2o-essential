###########################################################################
# a2o Essential Puppet Modules                                            #
#-------------------------------------------------------------------------#
# Copyright (c) 2012 Bostjan Skufca                                       #
#-------------------------------------------------------------------------#
# This source file is subject to version 2.0 of the Apache License,       #
# that is bundled with this package in the file LICENSE, and is           #
# available through the world-wide-web at the following url:              #
# http://www.apache.org/licenses/LICENSE-2.0                              #
#-------------------------------------------------------------------------#
# Authors: Bostjan Skufca <my_name [at] a2o {dot} si>                     #
###########################################################################
###
###
### Import libraries
###
###
import os
import subprocess
from subprocess import Popen, PIPE



###
###
### Global variables
###
###
descriptors = list()



###
###
### Data collector
###
###
def getMailQueueSize():
    dataCollector = '/etc/ganglia/data_collectors/a2o/mail_queue.sh'

    # Check if program even exists?
    if not os.path.exists(dataCollector):
	raidStatus = 'ERROR: File not found: ' + dataCollector
	return

    # Check if it is executable?
    if not os.access(dataCollector, os.X_OK):
	raidStatus = 'ERROR: File is not executable: ' + dataCollector
	return

    # Execute it and trim the output
    proc          = subprocess.Popen([dataCollector], stdout=PIPE)
    output        = proc.communicate()[0]
    mailQueueSize = output.strip()

    # Return back
    return mailQueueSize



###
###
### Data submission callbacks
###
###
def cb_mailQueue(name):
    return getMailQueueSize()



###
###
### Init metrics module
###
###
def metric_init(params):
    global descriptors

    d1 = {'name':      'mail_queue',
        'call_back':   cb_mailQueue,
        'time_max':    90,
        'value_type':  'uint',
        'units':       'messages',
        'slope':       'both',
        'format':      '%u',
        'description': 'Messages in queue',
        'groups':      'mail'
    }

    descriptors = [d1]
    return descriptors



def metric_cleanup():
    '''Clean up the metric module.'''
    pass



#This code is for debugging and unit testing    
if __name__ == '__main__':
    params = {}
    metric_init(params)
    for d in descriptors:
        v = d['call_back'](d['name'])
        print 'value for %s is %u' % (d['name'],  v)
