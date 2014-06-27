#!/bin/bash

#
# File locations
#
TEMPLATE_IN_FILE=resources/modify_rds.json

#
# AWS RDS modify command line and options
#
DBInstanceIdentifier=${DBInstanceIdentifier:-"<DBInstanceIdentifier>"}

CMD="aws rds modify-db-instance --db-instance-identifier ${DBInstanceIdentifier}" 

usage () {
   echo "Usage: ${CMD} --<PARAM> <VALUE> --<PARAM> <VALUE> ..."
   echo
   echo "where DBInstanceIdentifier is the identifier assigned to the instance by AWS,"
   echo "where PARAM is one of the following:"
   echo
   ./bin/find_cf_params ${TEMPLATE_IN_FILE}
   echo
   echo "and VALUE is set via environment variable where"
   echo "environment variable name is PARAM with hyphens omitted,"
   echo "e.g. export dbinstanceclass=db.m1.large"
   echo
   echo "NOTE: if --apply-immediate is omitted, any change requiring an outage will take"
   echo "effect during the next scheduled maintenance window."
   echo
   echo  To apply a change immediately set environment variable applyimmediately=true
   echo
}

while getopts :h option
do
        case $option in
        "h")
                usage
                exit ${EXIT_STATUS}
                ;;
         esac
done


#
# Generate modify RDS CLI command
#

# Load parameters from environment and build params argument line for 
#


PARAM_NAMES=$( ./bin/find_cf_params ${TEMPLATE_IN_FILE} )

# loop through Key Values in template and set P=Key Value and V=environment variable
# corresponding to key value;  environment variable name must be Key Value with
# hyphens omitted

# if applyimmediately environment variable is set don't add it's value to parameter list


for P in ${PARAM_NAMES}
do
        PP=$(eval echo $P | tr -d '-')
	V=$( eval echo \${${PP}} )
	if ! [ -z "${V}" ]; then
          if [ "${PP}" == "applyimmediately" ]; then
             PARAM_ARGS="$PARAM_ARGS --${P}"
          else
  	     PARAM_ARGS="$PARAM_ARGS --${P} ${V}"
          fi
  	fi
done

#
# Report and then run it
#
CMD="$CMD $PARAM_ARGS"
echo "Command to execute:"
echo "-----------------------"
echo $CMD

$CMD

