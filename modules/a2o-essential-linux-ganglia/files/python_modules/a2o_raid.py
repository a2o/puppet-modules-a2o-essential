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
raidStatus  = ''



###
###
### Data collector
###
###
def parseRaidStatus():
    global raidStatus
    raidScript = '/opt/scripts/raid/check'


    # Check if script even exists?
    if not os.path.exists(raidScript):
	raidStatus = 'ERROR: check script does not exist'
	return

    # Check if it is executable?
    if not os.access(raidScript, os.X_OK):
	raidStatus = 'ERROR: check script is not executable'
	return


    # Execute it and save trimmed output
    proc = subprocess.Popen([raidScript], stdout=PIPE)
    output = proc.communicate()[0]
    raidStatus = output.strip()


    # Return back
    return



###
###
### Data submission callback
###
###
def getRaidStatus(name):
    parseRaidStatus()
    global raidStatus
    return raidStatus



###
###
### Init metrics module
###
###
def metric_init(params):
    global descriptors

    d1 = {'name':      'raid_status',
        'call_back':   getRaidStatus,
        'time_max':    3600,
        'value_type':  'string',
        'units':       '',
        'slope':       'both',
        'format':      '%s',
        'description': 'Raid status',
        'groups':      'raid'
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
        print 'value for %s is %s' % (d['name'],  v)
