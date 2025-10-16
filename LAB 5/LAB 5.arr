use context dcic2024
include csv
include tables
include data-source



#TASK 1
#STEP 1

#Problem: The carrier column has inconsistent formatting (extra spaces, lowercase letters).
#Planned Step: "Clean the carrier column by trimming spaces and converting text to uppercase."

#Implementation: Use transform-column with a lambda that applies trim and string-to-upper to each value.

# Inputs: flight, carrier, dep_time, tailnum, dep_delay, arr_delay, distance, air_time
# Outputs: cleaned table, dedup_key column, visualisations
# Steps:
# 1. Replace missing tailnum values with "UNKNOWN"
# 2. Clean dep_delay and arr_delay: replace negative values with 0
# 3. Normalize carrier: trim spaces and convert to uppercase
# 4. Normalize dep_time to "HH:MM" format
# 5. Create dedup_key column: flight + carrier + dep_time
# 6. Remove duplicates using dedup_key
# 7. Map carrier codes to airline names
# 8. Filter outliers: distance > 5000 or air_time < 500
# 9. Visualize: bar chart (airline), histogram (distance), scatter plot (air_time vs distance)
# 10. Use for-each loop to compute total, average, and max distance


#STEP 2
#Problem: The tailnum column has blank cells with missing values.
#Planned Step: "Fill the tailnum column by filling the blank cells."

#Implementation: 
 




#TASK 2
# Load and sanitize
flights_sample53 = load-table:
  rownames :: Number,
  dep_time :: Number,
  sched_dep_time :: Number,
  dep_delay :: Number,
  arr_time :: Number,
  sched_arr_time :: Number,
  arr_delay :: Number,
  carrier :: String,
  flight :: Number,
  tailnum :: String,
  origin :: String,
  dest :: String,
  air_time :: Number,
  distance :: Number,
  hour :: Number,
  minute :: Number,
  time_hour :: String
  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end


# Replacing missing tailnum
fun fix-tail(t :: String) -> String:
  doc: "Replace empty tailnum with UNKNOWN"
  if t == "":
    "UNKNOWN"
  else:
    t
  end
end

flightssample = transform-column(flights_sample53, "tailnum", fix-tail)


# Clean delay columns
fun clean-delay(d :: Number) -> Number:
  doc: "Replace negative delay with 0"
  if d < 0:
    0
  else:
    d
  end
end

flights_53 = transform-column(transform-column(flights_sample53, "dep_delay", clean-delay), "arr_delay", clean-delay)

#TASK 2.3 — dedup_key column
# Helper functions
# Helper: Trim spaces from string
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end

# Helper: Format dep_time like 517 → "05:17"
fun format-time(t :: Number) -> String:
  doc: "Convert dep_time to HH:MM format"
  h = num-floor(t / 100)
  m = num-modulo(t, 100)
  h-str = if h < 10: string-append("0", num-to-string(h)) else: num-to-string(h) end
  m-str = if m < 10: string-append("0", num-to-string(m)) else: num-to-string(m) end
  string-append(string-append(h-str, ":"), m-str)

end

# Build dedup_key column
flights_5 = build-column(flights_53, "dedup_key",
  lam(r):
string-append(
  string-append(
    string-append(num-to-string(r["flight"]), "-"),
    string-append(string-to-upper(trim(r["carrier"])), "-")
  ),
  format-time(r["dep_time"])
)


  end
)




# Counting duplicates
grouped = group(flights_53, "dedup_key")
counted = count(flights_53, "dedup_key")



#TASK 3
#Airline Mapping and Outlier Filtering
fun map-airline(c :: String) -> String:
  doc: "Map carrier codes to airline names"
  if c == "UA": "United Airlines"
  else if c == "AA": "American Airlines"
  else if c == "B6": "JetBlue"
  else if c == "DL": "Delta Air Lines"
  else if c == "EV": "ExpressJet"
  else if c == "WN": "Southwest Airlines"
  else if c == "OO": "SkyWest Airlines"
  else: "Other"
  end
end

flightssample1 = build-column(flights_53, "airline",
  lam(r): map-airline(string-to-upper(trim(r["carrier"]))) end
)

flightssample2 = filter-with(flights_53,
  lam(r): (r["distance"] <= 5000) and (r["air_time"] >= 500) end
)



# TASK 4 
#4.1
# Bar chart: number of flights by airline
bar-chart(flightssample2, "airline")

# Histogram: distribution of flight distances
histogram(flightssample2, "distance")

# Scatter plot: air_time vs. distance
scatter-plot(flightssample2, "air_time", "distance")




#4.2
#I need more feedback on this task
distances = get-column(flightssample2, "distance")

# Initialize variables
var total = 0
var max = 0

# Loop through distances
for each d from distances:
  total := total + d
  if d > max:
    max := d
  end
end

# Computing average
avg = total / length(distances)

# Display results
total
avg
max









 

