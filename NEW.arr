use context starter2024

# --------------------------
# Orders Table and Filtering
# --------------------------

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

fun is-high-value(o :: Row) -> Boolean:
  o["amount"] >= 8.0
where:
  is-high-value(orders.row-n(0)) is true
  is-high-value(orders.row-n(1)) is false
end

new-high-orders = orders.filter(is-high-value)

check:
  new-high-orders is high-value-orders
end

# --------------------------
# Morning Orders and Sorting
# --------------------------

fun is-morning(o :: Row) -> Boolean:
  doc: "Returns true if the time in the row is before 12:00"
  o["time"] < "12:00"
end

morning-orders = orders.filter(is-morning)

check:
  is-morning(orders.row-n(0)) is true
  is-morning(orders.row-n(4)) is false
  morning-orders.length() is 3
end

morning-orders2 = orders.filter(lam(o): o["time"] < "12:00" end)

check:
  morning-orders2 is morning-orders
end

orders-by-time = orders.order-by("time", true)

check:
  orders-by-time.row-n(0)["time"] is "16:45"
  orders-by-time.row-n(orders-by-time.length() - 1)["time"] is "08:00"
end

latest-morning = morning-orders.order-by("time", true)
latest-morning-amount = latest-morning.row-n(0)["amount"]

check:
  latest-morning-amount is 8.0
end

# --------------------------
# Loading and Analyzing Photo Data
# --------------------------

photos = load-table:
  source: "https://pdi.run/f25-2000-photos.csv"
  schema: ("PhotoID", Number), ("Subject", String), ("Date", String), ("Location", String)
end

# --------------------------
# Forest Photo Functions
# --------------------------

fun filter-photos-with-subject-forest(photos):
  photos.filter(lam(r): r["Subject"] == "Forest" end)
end

fun order-forest-photos-by-date(forest-photos):
  forest-photos.order-by("Date", true)
end

fun count-forest-photos-by-location(forest-photos):
  forest-photos.count("Location")
end

fun location-counts-to-list(location-counts):
  location-counts.order-by("count", true)
end

# --------------------------
# Applying Forest Photo Functions
# --------------------------

forest-photos = filter-photos-with-subject-forest(photos)

check:
  forest-photos.filter(lam(r): r["Subject"] != "Forest" end).length() is 0
end

forest-by-date = order-forest-photos-by-date(forest-photos)
latest-forest-location = forest-by-date.row-n(0)["Location"]

check:
  string?(latest-forest-location) is true
end

location-counts = count-forest-photos-by-location(forest-photos)
location-counts-ordered = location-counts-to-list(location-counts)

top-location = location-counts-ordered.row-n(0)["Location"]
top-location-count = location-counts-ordered.row-n(0)["count"]

check:
  top-location-count >= location-counts-ordered.row-n(location-counts-ordered.length() - 1)["count"]
end

freq-chart = frequency-bar-chart(photos, "Location")
