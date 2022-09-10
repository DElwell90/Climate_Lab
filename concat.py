#!/usr/bin/python3
'''
This script concatenates the 2020 thru 2022 climate files that we downloaded.
'''
import pandas as pd

dir="~/Desktop/Climate_Lab"
combined_climate = pd.DataFrame()

for year in ['2020','2021','2022']:
    climate_year = pd.read_csv(f'{dir}/climate{year}.csv')
    combined_climate = pd.concat([combined_climate,climate_year],axis=0)

combined_climate.to_csv(f'{dir}/all_years.csv')