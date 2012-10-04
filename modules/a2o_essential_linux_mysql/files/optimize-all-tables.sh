#!/bin/bash



### Runtime config - from command line - TODO
FORCE_REPAIR="0"



### Configuration
MYSQL_CMD="/usr/local/bin/mysql"
SKIP_DATABASES='information_schema c_geo'
SKIP_TABLES='mysql.general_log mysql.slow_log'
SKIP_TABLE_ENGINES='MEMORY NULL InnoDB'
SKIP_TABLE_ENGINES_OPTIMIZE=' MRG_MyISAM MRG_MYISAM InnoDB ' # Start and end space are mandatory!
IGNORED_CHECK_RESULTS_REGEX="\(Found row where the auto_increment column has the value 0\)"



### Get all databases
CMD='echo "SHOW DATABASES" | $MYSQL_CMD --skip-column-names'
DBS=`eval $CMD`
if [ "$?" -ne "0" ]; then
    echo "ERROR: Unable to get database list, exiting"
    exit 1
fi



### Loop through DBs
ERROR_OCCURED=0
for DB in $DBS; do



    ### Shall we skip it?
    RES=`echo "$SKIP_DATABASES" | fgrep "$DB" | grep -c .`
    if [ "$RES" -eq "1" ]; then
	echo "$DB skipping"
	continue
    fi

    
	
    ### Start the process
    echo "$DB start"



    ### Get tables in given database
    CMD="echo 'SHOW TABLES' | $MYSQL_CMD --skip-column-names --database=$DB"
    TABLES=`eval $CMD`
    if [ "$?" -ne "0" ]; then
	echo "ERROR: Unable to get table list, skipping this database"
	continue
    fi



    ### Loop through tables in given database
    for TABLE in $TABLES; do



	# Shall we skip it?
	RES=`echo "$SKIP_TABLES" | fgrep "$DB.$TABLE" | grep -c .`
	if [ "$RES" -eq "1" ]; then
	    echo "  $DB.$TABLE: skipping"
	    continue
	fi



	echo -n "  $DB.$TABLE... "
	REPAIR_TABLE=0



        # Get table storage engine
        CMD="echo \"SELECT ENGINE FROM information_schema.TABLES WHERE TABLE_SCHEMA='$DB' AND TABLE_NAME='$TABLE'\" | $MYSQL_CMD --skip-column-names --database=$DB"
        CMD_RESULT=`eval $CMD`
        if [ "$?" -ne "0" ]; then
            echo "ERROR: Unable to get table storage engine type, skipping ($CMD_RESULT)"
            ERROR_OCCURED=1
            continue
        fi
        TABLE_ENGINE="$CMD_RESULT"



        # Shall we skip it (engine does not support anything)?
        CMD="echo '$SKIP_TABLE_ENGINES' | fgrep -c $TABLE_ENGINE"
        CMD_RESULT=`eval $CMD`
        if [ "$CMD_RESULT" != "0" ]; then
            echo "skipping ($TABLE_ENGINE storage engine)"
            continue
        fi



	# Do check
	echo -n "CHECK... "
        CMD="echo 'CHECK TABLE \`$TABLE\`' | $MYSQL_CMD --skip-column-names --database=$DB | grep -v '$IGNORED_CHECK_RESULTS_REGEX'"
	CMD_RESULT=`eval $CMD`
	if [ "$?" -ne "0" ]; then
	    echo "ERROR: Unable to check table, skipping ($CMD_RESULT)"
	    ERROR_OCCURED=1
	    continue
	fi

	# How many lines of response?
	RES=`echo "$CMD_RESULT" | grep -c .`
	if [ "$RES" -ne "1" ]; then
	    echo "ERROR: Invalid number of result lines: $RES"
	    echo "MESSAGE:"
	    echo "$CMD_RESULT"
	    ERROR_OCCURED=1
	    continue
	fi

	# Extract valuable info
	CMD_RESULT_TYPE=`echo $CMD_RESULT | cut -d' ' -f3`
	CMD_RESULT_MESSAGE=`echo $CMD_RESULT | cut -d' ' -f4-`

	# Ist alles gut?
	if [ "$CMD_RESULT_TYPE" == "status" ] && [ "$CMD_RESULT_MESSAGE" == "OK" ]; then
	    echo -n "table OK... "
	else
	    echo "ERROR: Missing implementation for this result type & message"
	    echo "TYPE: $CMD_RESULT_TYPE"
	    echo "MESSAGE: $CMD_RESULT_MESSAGE"
	    echo
	    ERROR_OCCURED=1
	    continue
	fi

	    # Is check supported?	
#	    RES=`echo "$CMD_RESULT" | fgrep "The storage engine for the table doesn't support check" | grep -c .`
#	    if [ "$RES" -eq "1" ]; then
#		echo -n "Check not supported, forcing repair... "
#		REPAIR_TABLE="1"
#	    fi

	# Do we have to repair it?
#	RES=`echo "$CMD_RESULT" | fgrep "check" | fgrep "status" | fgrep "OK" | grep -c .`
#	if [ "$RES" -ne "1" ]; then
#	    echo -n "table corrupted... "
#	    REPAIR_TABLE="1"
#	fi

	# Is repair forced?
	if [ "$FORCE_REPAIR" == "1" ]; then
	    echo -n "forced repair... "
	    REPAIR_TABLE="1"
	fi


	# Repair table
	if [ "$REPAIR_TABLE" == "1" ]; then
	    echo -n "REPAIR... "
    	    CMD="echo 'REPAIR TABLE \`$TABLE\`' | $MYSQL_CMD --skip-column-names --database=$DB"
	    CMD_RESULT=`eval $CMD`
	    if [ "$?" -ne "0" ]; then
		echo "ERROR: Unable to repair table, skipping ($CMD_RESULT)"
		ERROR_OCCURED=1
		continue
	    fi

	    # Was repair sucessfull?
	    RES=`echo "$CMD_RESULT" | fgrep "repair" | fgrep "status" | grep "\(OK\|Table is already up to date\)" | grep -c .`
	    if [ "$RES" -ne "1" ]; then
		echo "ERROR: repair did not succeed ($CMD_RESULT)"
		ERROR_OCCURED=1
		continue
	    fi
	fi



        # Shall we skip it (engine does not support optimize & analyze)?
        CMD="echo '$SKIP_TABLE_ENGINES_OPTIMIZE' | fgrep -c ' $TABLE_ENGINE '"
        CMD_RESULT=`eval $CMD`
        if [ "$CMD_RESULT" != "0" ]; then
            echo "skipping optimize & analyze ($TABLE_ENGINE storage engine)"
            continue
        fi



	# Do optimize
	echo -n "OPTIMIZE... "
        CMD="echo 'OPTIMIZE TABLE \`$TABLE\`' | $MYSQL_CMD --skip-column-names --database=$DB"
	CMD_RESULT=`eval $CMD`
	if [ "$?" -ne "0" ]; then
	    echo "ERROR: Unable to optimize table, skipping ($CMD_RESULT)"
	    ERROR_OCCURED=1
	    continue
	fi

	# Was optimize sucessfull?
	RES=`echo "$CMD_RESULT" | fgrep "optimize" | fgrep "status" | grep "\(OK\|Table is already up to date\)" | grep -c .`
	if [ "$RES" -ne "1" ]; then
	    echo "ERROR: optimize did not succeed ($CMD_RESULT)"
	    ERROR_OCCURED=1
	    continue
	fi



	# Do analyze
	echo -n "ANALYZE... "
        CMD="echo 'ANALYZE TABLE \`$TABLE\`' | $MYSQL_CMD --skip-column-names --database=$DB"
	CMD_RESULT=`eval $CMD`
	if [ "$?" -ne "0" ]; then
	    echo "ERROR: Unable to analyze table, skipping ($CMD_RESULT)"
	    ERROR_OCCURED=1
	    continue
	fi

	# Was analyze sucessfull?
	RES=`echo "$CMD_RESULT" | fgrep "analyze" | fgrep "status" | grep "\(OK\|Table is already up to date\)" | grep -c .`
	if [ "$RES" -ne "1" ]; then
	    echo "ERROR: analyze did not succeed ($CMD_RESULT)"
	    ERROR_OCCURED=1
	    continue
	fi

    	echo "done."
    done
done



### Signal end
echo "All done."


if [ "$ERROR_OCCURED" != "0" ]; then
    exit 1
fi
