use context dcic2024
include csv
include data-source
include tables

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

new-high-orders = filter-with(orders, is-high-value)

check:
  new-high-orders is high-value-orders
end
order-by(orders, "amount", true)

#Class Exercises
#

# Designing an is-morning function to see if the time column in a row represents a morning.
#Defining the function
fun is-morning(o :: Row) -> Boolean:
  doc: "Returns true if the time in the row is before 12:00 which means morning"
  o["time"] < "12:00"
end

morning-orders = filter-with(orders, is-morning)

check:
  is-morning(orders.row-n(1)) is true
  is-morning(orders.row-n(5)) is false
  morning-orders.length() is 4
end

# This is the same is-morning but as an unnamed lambda function
morning-orders2 = filter-with(orders, lam(o): o["time"] < "12:00" end)

#Checking if it's the same as the first
check:
  morning-orders2 is morning-orders
end




#Creating a table where the orders are sorted by time from latest to earliest, rather than how the original table is sorted.
# Sorting orders by time (latest to earliest)
orders-by-time = order-by(orders, "time", true)

check:
  orders-by-time.row-n(0)["time"] is "08:00"
  orders-by-time.row-n(orders-by-time.length() - 1)["time"] is "16:45"
end

# Extract the amount of the latest morning order
latest-morning = morning-orders.order-by("time", true)
latest-morning-amount = latest-morning.row-n(0)["amount"]

check:
  latest-morning-amount is 10.50
end


#Loading data using table
#Loading the data(table)
datasets = load-table:
  Location :: String,
  Subject :: String,
  Date :: Number
  source: csv-table-file("photos.csv", default-options)
end
    

#Maybe using Link ?
        #photos = load-table: 
        #  source: "https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv"
    
        #end

# Order forest photos by date, get location of the most recent
forest-by-date = order-by(datasets, "Date", true)
latest-forest-location = forest-by-date.row-n(0)["Location"]


# Count photos by Location
location-counts = count(datasets, "Location")

# Order by number of photos (descending)
location-counts-ordered = order-by(location-counts, "count", true)


# Frequency bar chart for Location column
freq-chart = freq-bar-chart(datasets, "Location")
