use context dcic2024
include csv
include data-source

#LECTURE NOTES
#TABLES
#A table is a form of a compound data structure which acts a container for multiple data types
#Tables are values, just like numbers, strings, images, and booleans, and small ones can be directly typed into Pyret as:

workouts = table:
  date :: String, 
  activity :: String,
  duration :: Number
  row: "2025-04-01", "Running", 30
  row: "2025-04-02", "Yoga", 45
  row: "2025-04-03", "Cycling", 60
end

workouts





#Since tables are values, they can be the input and output of functions, and can be used in examples. An important detail: when comparing tables for equality (like in test cases) the order of rows matters!
#We can use check: ... end to write a set of tests not associated with a function, and use that to see:
check:
  table: date :: String, activity :: String, duration :: Number
    row: "2025-04-01", "Running", 30
    row: "2025-04-02", "Yoga", 45
    row: "2025-04-03", "Cycling", 60
  end
  is-not
  table: date :: String, activity :: String, duration :: Number
    row: "2025-04-03", "Cycling", 60
    row: "2025-04-01", "Running", 30
    row: "2025-04-02", "Yoga", 45
  end
end

#|Extracting Rows and Column Values from a Table
In addition to printing the whole table (or a prefix, if the table is long), you can extract a row from it by writing table-identifier.row-n(N) for some N. The first row is numbered 0, the last is one minus the number in the table|#
second-workout = workouts.row-n(1)
# -> Row: date = "2025-04-02", activity = "Yoga", duration = 45
#From a row, you can extract a column values using row-identifier["column-name"]
second-workout["activity"]  # -> "Yoga"
# or all at once:
workouts.row-n(1)["duration"]  # -> 45

#There are also built-in functions that compute results—e.g., mean takes a table, a column name, and returns the average of all values in that column. Other functions like median, modes, sum, and stdev exist as well!






#|Importing Tables from CSV
To deal with external files, we need to first include a Pyret piece of functionality that is not enabled by default to handle tables represented as comma separated valueLinks to an external site. (CSV) files.
CSV files can be loaded using the CSV module which should be imported at the top of the file
This gives us access to the load-table function and other associated functions, including thedefault-options.
include csv
Importing CSV files from a URL
We can use load-table: to load a table from a csv file:
We can use the csv-table-url function to load files from the web
recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/recipes.csv", default-options)
end
Importing CSV files
A local CSV file can be loadedLinks to an external site. using the csv-table-file function
Upload any files to the same location as the .arr file first by right clicking inside the Explorer tab in VS Code and clicking Upload.
recipes = load-table:
  title :: String,
  servings :: Number,
  prep-time :: Number
  source: csv-table-file("recipes.csv", default-options)
   end  |#



#The lr-plot function creates a linear regression plot which attempts to draw a regression line inside a scatter plot
include csv
include data-source

world-bank = load-table:
  country :: String,
  life-exp :: Number,
  gdp :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/life_exp_gdp.csv", default-options)
  sanitize life-exp using num-sanitizer
  sanitize gdp using num-sanitizer
end

lr-plot(world-bank, "gdp", "life-exp")























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
  


