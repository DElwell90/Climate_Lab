#!/bin/bash

: '
In this script, we download Climate Data for Toronto.

We download the data using wget and focus on these parameters:

    Station ID = 48549
    Years = 2020 thru 2022
    Month = February
    Format = Hourly
'

#####################################################################
#Set Variables
HOST=$HOSTNAME

SHORT_DATE=`date '+%Y-%m-%d'`

TIME=`date '+%H%M'`

SCRIPT_TYPE=`basename $0 | cut -d '.' -f1` ##(get the first line of the file )

filenametime1=$(date +"%m%d%Y%H%M%S")
filenametime2=$(date +"%Y-%m-%d %H:%M:%S")

export dir='/home/development/Desktop/Climate_Lab'
export LOGDIR=${dir}/Logs
export SHELL_SCRIPT_NAME='shell_script'
export LOG_FILE=${LOGDIR}/${SHELL_SCRIPT_NAME}_${filenametime1}.log

#####################################################################
#Log rules
touch $LOG_FILE
exec > >(tee ${LOG_FILE}) 2>&1

#####################################################################
#Download Data using wget
for year in {2020..2022}; 
do 
wget  --directory-prefix=${dir} -O climate${year}.csv "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&timeframe=1&submit= Download+Data"
done;

RC1=$?
if [ ${RC1} != 0 ]; then
    echo "Data Download FAILED"
    echo "ERROR: Return CODE: ${RC1}"
    echo "ERROR: Refer to the Log for reason of failure"
    exit 1
fi

#####################################################################
#Run python script.
`${dir}/concat.py`

RC1=$?
if [ ${RC1} != 0 ]; then
	echo "PYTHON RUNNING FAILED"
	echo "[ERROR:] RETURN CODE:  ${RC1}"
	echo "[ERROR:] REFER TO THE LOG FOR THE REASON FOR THE FAILURE."
	exit 1
fi

#####################################################################
#Remove files for individuals years
for year in {2020..2022};
do
`rm climate${year}.csv`
done;

#####################################################################
#Print success message
echo "SUCCESS"

#####################################################################
#Return 0, as it is a success
exit 0