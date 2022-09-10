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

#############################################################
#Define Directory
dir="~/Desktop/Climate_Lab"

for year in {2020..2022}; 
do 
wget  --directory-prefix=${dir} -O climate${year}.csv "https://climate.weather.gc.ca/climate_data/bulk_data_e.html?format=csv&stationID=48549&Year=${year}&Month=2&timeframe=1&submit= Download+Data" 
done;

#Run python script.
`${dir}/concat.py`

#Remove each year's data
for year in {2020..2022};
do
`rm climate${year}.csv`
done;

#Print success
echo "SUCCESS"