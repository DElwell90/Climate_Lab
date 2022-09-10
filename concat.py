#!/usr/bin/python3
'''
This script concatenates the 2020 thru 2022 climate files
'''
import pandas as pd

combined_climate = pd.DataFrame()

for year in ['2020','2021','2022']:
    climate_year = pd.read_csv(f'./climate_data/climate{year}.csv')
    combined_climate = pd.concat([combined_climate,climate_year],axis=0)

combined_climate.to_csv('./climate_data/all_years.csv')