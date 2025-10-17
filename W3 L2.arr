use context dcic2024
include csv
include data-source


#W3 L2

#CLASS EXERCISES

#loading the given table 
plant_sightings = load-table:
  plant_common_name :: String,
  location_latitude :: String,
  location_longitude :: String,
  date-sighted :: String,
  soil_type :: String,
  plant_height_cm :: String,
  plant_color :: String #Initially I set only 3 columns then I received an error stating that there are 3 columns
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/plant_sightings.csv", default-options)
end

plant_sightings
  


