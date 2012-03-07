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
descriptors = list()
stateData   = {
    'time': {
        'prev': -1,
        'cur' : -1,
    },
    'proc': {
	'forkrate': {
    	    'prev' : -1,
    	    'cur'  : -1,
    	    'value':  0,
	},
    },
    'sys': {
	'ctxt': {
    	    'prev' : -1,
    	    'cur'  : -1,
    	    'value':  0,
	},
	'intr': {
    	    'prev' : -1,
    	    'cur'  : -1,
    	    'value':  0,
	},
    },
}



###
###
### Data collector
###
###
def parseProcStats():
    global stateData
    runData = {
        'time': {
	    'cur'  : 0,
    	    'diff' : 1,
	},
	'proc': {
	    'forkrate': 0,
	},
	'sys': {
	    'ctxt': 0,
	    'intr': 0,
	},
    }
    valueDiff  = 0
    valueFloat = 0
    value      = 0


    # Get current time
    runData['time']['cur'] = time.time()

    # Read file and search for data
    file  = open('/proc/stat', 'r')
    regexProc = re.compile('^processes (\d+)$')
    regexCtxt = re.compile('^ctxt (\d+)$')
    regexIntr = re.compile('^intr (\d+)')
    for line in file.readlines():
	match = regexProc.match(line)
	if match:
	    runData['proc']['forkrate'] = int(match.group(1))
	    continue

	match = regexCtxt.match(line)
	if match:
	    runData['sys']['ctxt'] = int(match.group(1))
	    continue

	match = regexIntr.match(line)
	if match:
	    runData['sys']['intr'] = int(match.group(1))
	    continue

    file.close()


    # Is this the first time the data is being collected?
    if stateData['proc']['forkrate']['cur'] == -1:
	stateData['time']['cur']             = runData['time']['cur']
	stateData['proc']['forkrate']['cur'] = runData['proc']['forkrate']
	stateData['sys']['ctxt']['cur'] = runData['sys']['ctxt']
	stateData['sys']['intr']['cur'] = runData['sys']['intr']
	return


    # Second and subsequent time data is being collected, parse it!
    stateData['time']['prev']             = stateData['time']['cur']
    stateData['proc']['forkrate']['prev'] = stateData['proc']['forkrate']['cur']
    stateData['sys'] ['ctxt']    ['prev'] = stateData['sys']['ctxt']['cur']
    stateData['sys'] ['intr']    ['prev'] = stateData['sys']['intr']['cur']
    stateData['time']['cur']              = runData['time']['cur']
    stateData['proc']['forkrate']['cur']  = runData['proc']['forkrate']
    stateData['sys'] ['ctxt']    ['cur']  = runData['sys']['ctxt']
    stateData['sys'] ['intr']    ['cur']  = runData['sys']['intr']


    # Calculate time difference
    runData['time']['diff'] = stateData['time']['cur'] - stateData['time']['prev']


    # Calculate values
    valueDiff  = stateData['proc']['forkrate']['cur'] - stateData['proc']['forkrate']['prev']
    valueFloat = (valueDiff) / runData['time']['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['proc']['forkrate']['value'] = value
    else:
	stateData['proc']['forkrate']['value'] = 0

    valueDiff  = stateData['sys']['ctxt']['cur'] - stateData['sys']['ctxt']['prev']
    valueFloat = (valueDiff) / runData['time']['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['sys']['ctxt']['value'] = value
    else:
	stateData['sys']['ctxt']['value'] = 0

    valueDiff  = stateData['sys']['intr']['cur'] - stateData['sys']['intr']['prev']
    valueFloat = (valueDiff) / runData['time']['diff']
    value      = int(round(valueFloat))
    if value >= 0:
	stateData['sys']['intr']['value'] = value
    else:
	stateData['sys']['intr']['value'] = 0


    # Return back
    return



###
###
### Data submission callbacks
###
###
def procForkrate(name):
    parseProcStats()
    global stateData
    return stateData['proc']['forkrate']['value']

def sysCtxt(name):
    global stateData
    return stateData['sys']['ctxt']['value']

def sysIntr(name):
    global stateData
    return stateData['sys']['intr']['value']



###
###
### Init metrics module
###
###
def metric_init(params):
    global descriptors
    
    d1 = {'name':      'proc_forkrate',
        'call_back':   procForkrate,
        'time_max':    90,
        'value_type':  'uint',
        'units':       '',
        'slope':       'both',
        'format':      '%u',
        'description': 'Process creation rate',
        'groups':      'process'
    }
    d2 = {'name':      'sys_ctxt',
        'call_back':   sysCtxt,
        'time_max':    90,
        'value_type':  'uint',
        'units':       '',
        'slope':       'both',
        'format':      '%u',
        'description': 'Context switches',
        'groups':      'sys'
    }
    d3 = {'name':      'sys_intr',
        'call_back':   sysIntr,
        'time_max':    90,
        'value_type':  'uint',
        'units':       '',
        'slope':       'both',
        'format':      '%u',
        'description': 'Interrupts',
        'groups':      'sys'
    }

    descriptors = [d1, d2, d3]
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
