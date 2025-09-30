use context dcic2024

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

high-value-orders = table: time, amount
  row: "08:00", 10.50
  row: "10:15", 8.00
end
#Here we consider the first row as row 0, so row 1 is row 1.
fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0
where:
  is-high-value(orders.row-n(2)) is true
  is-high-value(orders.row-n(3)) is false
end

new-high-orders = orders.filter(is-high-value)

check:
  new-high-orders is high-value-orders
end
order-by(orders, "amount", true)

#Class Exercises
#


orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

# Designing an is-morning function to see if the time column in a row represents a morning.
#Defining the function
fun is-morning(o :: Row) -> Boolean:
  doc: "Returns true if the time in the row is before 12:00 which means morning"
  o["time"] < "12:00"
end

morning-orders = orders.filter(is-morning)

check:
  is-morning(orders.row-n(1)) is true
  is-morning(orders.row-n(5)) is false
  morning-orders.length() is 3
end

# This is the same is-morning but as an unnamed lambda function
morning-orders2 = orders.filter(lam(o): o["time"] < "12:00" end)

#Checking if it's the same as the first
check:
  morning-orders2 is morning-orders
end




#Creating a table where the orders are sorted by time from latest to earliest, rather than how the original table is sorted.
# Sorting orders by time (latest to earliest)
orders-by-time = orders.order-by("time", true)

check:
  orders-by-time.row-n(1)["time"] is "16:45"
  orders-by-time.row-n(orders-by-time.length())["time"] is "08:00"
end

# Extract the amount of the latest morning order
latest-morning = morning-orders.order-by("time", true)
latest-morning-amount = latest-morning.row-n(1)["amount"]

check:
  latest-morning-amount is 8.0
end

#Loading the data
photos = load-table: 
  source: "https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv"
    
  schema: ("PhotoID", Number), ("Subject", String), ("Date", String), ("Location", String)
end

# Filter rows that have subject "Forest"
forest-photos = photos.filter(lam(r): r["Subject"] == "Forest" end)

check:
  forest-photos.filter(lam(r): r["Subject"] != "Forest" end).length() is 0
end

# Order forest photos by date, get location of the most recent
forest-by-date = forest-photos.order-by("Date", true)
latest-forest-location = forest-by-date.row-n(1)["Location"]

# Can't check exact value without looking at the dataset, so just check it's a String
check:
  string? (latest-forest-location) is true
end

# Count photos by Location
location-counts = photos.count("Location")

# Order by number of photos (descending)
location-counts-ordered = location-counts.order-by("count", true)

check:
  location-counts-ordered.row-n(1)["count"] >= location-counts-ordered.row-n(location-counts-ordered.length())["count"]
end

# Frequency bar chart for Location column
freq-chart = frequency-bar-chart(photos, "Location")
