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
import re
import time



###
###
### Global variables
###
###
descriptors        = list()
stateDataTime = {
    'prev': -1,
    'cur':  -1,
}
stateData = {
    'ops': {
	'read': {
	    'prev'  : -1,
	    'cur'   : -1,
	    'value' :  0,
	},
	'write': {
	    'prev'  : -1,
	    'cur'   : -1,
	    'value' :  0,
	},
    },
    'time': {
	'read': {
	    'prev'  : -1,
	    'cur'   : -1,
	    'value' :  0,
	},
	'write': {
	    'prev'  : -1,
	    'cur'   : -1,
	    'value' :  0,
	},
    },
}



###
###
### Data collector
###
###
def parseProcDiskstats():
    global stateDataTime
    global stateData
    runDataTime = {
	'cur'  : 0,
	'diff' : 1,
    }
    sumData = {
	'ops' : {
	    'read' : 0,
	    'write': 0,
	},
	'time' : {
	    'read' : 0,
	    'write': 0,
	},
    }
    valueDiff  = 0
    valueFloat = 0
    value      = 0


    # Get current time
    runDataTime['cur'] = time.time()

    # Read file and search for data
    file  = open('/proc/diskstats', 'r')
    for line in file.readlines():
	match = re.search(r'([hs]d[a-z]|xvd[a-z]|cciss/c[0-9]+d[0-9]+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+) (\d+)$', line)
	if match:
	    sumData['ops'] ['read']  += int(match.group(2))
	    sumData['ops'] ['write'] += int(match.group(6))
	    sumData['time']['read']  += int(match.group(5))
	    sumData['time']['write'] += int(match.group(9))
    file.close()


    # Is this the first time the data is being collected?
    if stateData['ops']['read']['cur'] == -1:
	stateDataTime['cur']              = runDataTime['cur']
	stateData['ops'] ['read'] ['cur'] = sumData['ops'] ['read']
	stateData['ops'] ['write']['cur'] = sumData['ops'] ['write']
	stateData['time']['read'] ['cur'] = sumData['time']['read']
	stateData['time']['write']['cur'] = sumData['time']['write']
	return


    # Second and subsequent time data is being collected, parse it!
    stateDataTime['prev']              = stateDataTime['cur']
    stateData['ops'] ['read'] ['prev'] = stateData['ops'] ['read'] ['cur']
    stateData['ops'] ['write']['prev'] = stateData['ops'] ['write']['cur']
    stateData['time']['read'] ['prev'] = stateData['time']['read'] ['cur']
    stateData['time']['write']['prev'] = stateData['time']['write']['cur']
    stateDataTime['cur']               = runDataTime['cur']
    stateData['ops'] ['read'] ['cur']  = sumData['ops'] ['read']
    stateData['ops'] ['write']['cur']  = sumData['ops'] ['write']
    stateData['time']['read'] ['cur']  = sumData['time']['read']
    stateData['time']['write']['cur']  = sumData['time']['write']


    # Calculate time difference
    runDataTime['diff'] = stateDataTime['cur'] - stateDataTime['prev']


    # Calculate values
    valueDiff  = stateData['ops']['read']['cur'] - stateData['ops']['read']['prev']
    valueFloat = (valueDiff) / runDataTime['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['ops']['read']['value'] = value
    else:
	stateData['ops']['read']['value'] = 0

    valueDiff  = stateData['ops']['write']['cur'] - stateData['ops']['write']['prev']
    valueFloat = (valueDiff) / runDataTime['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['ops']['write']['value'] = value
    else:
	stateData['ops']['write']['value'] = 0

    valueDiff  = stateData['time']['read']['cur'] - stateData['time']['read']['prev']
    valueFloat = (valueDiff) / runDataTime['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['time']['read']['value'] = value
    else:
	stateData['time']['read']['value'] = 0

    valueDiff  = stateData['time']['write']['cur'] - stateData['time']['write']['prev']
    valueFloat = (valueDiff) / runDataTime['diff'] / 100   # possibly incorrect, but in sync with collectd
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['time']['write']['value'] = value
    else:
	stateData['time']['write']['value'] = 0


    # Return back
    return



###
###
### Data submission callbacks
###
###
def diskOpsRead(name):
    parseProcDiskstats()
    global stateData
    return stateData['ops']['read']['value']

def diskOpsWrite(name):
    global stateData
    return stateData['ops']['write']['value']

def diskTimeRead(name):
    global stateData
    return stateData['time']['read']['value']

def diskTimeWrite(name):
    global stateData
    return stateData['time']['write']['value']



###
###
### Init metrics module
###
###
def metric_init(params):
    global descriptors

    d1 = {'name':      'disk_ops_read',
        'call_back':   diskOpsRead,
        'time_max':    90,
        'value_type':  'uint',
        'units':       '',
        'slope':       'both',
        'format':      '%u',
        'description': 'Disk read OPS',
        'groups':      'disk'
    }
    d2 = {'name':      'disk_ops_write',
        'call_back':   diskOpsWrite,
        'time_max':    90,
        'value_type':  'uint',
        'units':       '',
        'slope':       'both',
        'format':      '%u',
        'description': 'Disk write OPS',
        'groups':      'disk'
    }

    d3 = {'name':      'disk_time_read',
        'call_back':   diskTimeRead,
        'time_max':    90,
        'value_type':  'uint',
        'units':       'ms',
        'slope':       'both',
        'format':      '%u',
        'description': 'Disk read time',
        'groups':      'disk'
    }
    d4 = {'name':      'disk_time_write',
        'call_back':   diskTimeWrite,
        'time_max':    90,
        'value_type':  'uint',
        'units':       'ms',
        'slope':       'both',
        'format':      '%u',
        'description': 'Disk write time',
        'groups':      'disk'
    }

    descriptors = [d1, d2, d3, d4]
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
