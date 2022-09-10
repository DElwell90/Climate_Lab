#!/bin/bash

: '
Download the data using wget

Use wget to do it

Station ID = 48549
Years = 2020 thru 2022
Month = February
Format = Hourly
Output file = all_years.csv
'

if [ -d "climate_data" ]
then
`rm -r climate_data`
fi

`mkdir climate_data`

for year in {2020..2022}; 
do 
wget  --directory-prefix=./climate_data/ -O climate_data/climate${year}.csv "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&timeframe=1&submit= Download+Data" 
done;

#Run python script.
`./concat.py`
echo "SUCCESS"