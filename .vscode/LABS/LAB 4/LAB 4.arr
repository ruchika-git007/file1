use context dcic2024
#LAB 4 TEMPORARY CODE
include csv
include data-source


#EXERCISE 1
#1.1
flights = load-table:
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
  source: csv-table-file("flights.csv", default-options)
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

flights





#1.2 
#A predicate in Pyret is a function that returns a boolean value (true or false). These are used to test if a condition is met, for example, to filter data or check the type of a value. 

#Doc: "Checks if a flight is long-distance (≥ 1500 miles)"
fun is_long_flight(row :: Row) -> Boolean:
  row["distance"] >= 1500 
end





#1.3
long-flights = filter-with(flights, is_long_flight)
long-flights





#1.4
#order-by(t :: Table, colname :: String, sort-up :: Boolean) -> Table
#true is ascending and false is descending.
ordered-data = order-by(flights, "air_time", false) 





#1.5
#Extracting the carrier, origin, and dest of the first row
#Row Extraction
#t.row-n(n :: Number) -> Row
#For a table t, returns the nth row, where row numbers start at 0

#first-student = students.row-n(0)
#third-student = students.row-n(2)

#Getting a value
#The syntax my-row[col-name] accesses a row at a particular column, resulting in a particular value. e.g. my-row["age"] → 20.

#first-student = students.row-n(0)
#alex-score = first-student["score"]
#alex-grade = first-student["grade"]

first-row = flights.row-n(0)

carrier = first-row["carrier"]
origin = first-row["origin"]
dest = first-row["dest"]










#EXERCISE 2
#2.1
# Doc: "Checks if departure delay is ≥ 30 minutes"
fun is_delayed_departure(row):
  row["dep_delay"] >= 30
end





#2.2
# Doc: "Checks if scheduled departure is before noon"
fun is_morning_sched_dep(row):
  row["sched_dep_time"] < 1200
end





#2.3

morning-delayed-flights = filter-with(
  filter-with(flights, lam(r): r["dep_delay"] >= 30 end),
  lam(r): r["sched_dep_time"] < 1200 end)
#The above code is an example of nested-filtering on a table
# There's an inner filter-with:
# filter-with(flights, lam(r): r["dep_delay"] >= 30 end) # This filters the flights table to include only rows where the departure delay is 30 minutes or more. Additionally, the r["dep_delay"] accesses the value in the "dep_delay" column for each row r.

# There's also a outer filter-with:
# filter-with(..., lam(r): r["sched_dep_time"] < 1200 end)
# This takes the result of the first filter and applies it to the second filter.
# It keeps only flights scheduled to depart before 12:00 PM (noon).
# The r["sched_dep_time"] is assumed to be in 24-hour format (e.g., 0930 for 9:30 AM).

#W ecan use the nested on build-column and transform column as well.

morning-delayed-flights





#2.4
morning-delayed-flights1 = filter-with(morning-delayed-flights, lam(r): r["distance"] > 500 end)
morning-delayed-flights1


 

#2.5
worst = order-by(morning-delayed-flights1, "dep_delay", false)
#If I just use order-by(table, "column-name", false) then I'm telling pyret to sort the entire table by "column-name" in descending order (false means descending).
# So the result is still a table, just reordered.

#But if you want to extract the single top row like the flight with the longest air time or worst delay, then you need to access it directly. That's where .row-n(0) comes in:
#order-by(table, "column-name", false).row-n(0)
#This gives you the first row of the sorted table, which is now the maximum value in that column.

worst


#2.6
worst1 = order-by(morning-delayed-flights1, "dep_delay", false).row-n(0)
worst-flight = worst1["flight"] 
worst-origin = worst1["origin"]
worst-delay = worst1["dep_delay"]
worst-flight
worst-origin
worst-delay










#EXERCISE 3
#3.1
# Transform Column
#transform-column(t :: Table, colname :: String, f :: (A -> B)) -> Table
#Consumes a table, a column name and a transformation function, and produces a new table where the given function has been applied to all values in the named column. The values in the original column are of type A (the input to the function) and values in the new column have type B (the output of the function).
# fun add-bonus(score :: Number) -> Number:
#   score + 5
# end
# bonus-scores = transform-column(students,  "score", add-bonus)

fun clean-delays(a :: Number) -> Number:
  if a < 0:
    0
  else:
    a
  end
end

flights-cleaned = transform-column(
  transform-column(flights, "dep_delay", clean-delays),
  "arr_delay", clean-delays
)

flights-cleaned






#3.2
# Add a letter grade column based on score
# fun calc-letter-grade(r :: Row) -> String:
#   score = r["score"]
#   if score >= 90: "A"
#   else if score >= 80: "B"
#   else if score >= 70: "C"
#   else if score >= 60: "D"
#   else: "F"
#   end
# end
# students-with-grades = build-column(students, "letter-grade", calc-letter-grade)
# Doc: "Computes effective speed in miles per hour"
fun with-speed(r :: Row) -> Number:
  air_time = r["air_time"]
  distance = r["distance"]
  if air_time > 0:
    distance / (air_time / 60)
  else:
    0
  end
end

flights-with-speed = build-column(flights-cleaned, "effective_speed", with-speed)

flights-with-speed




#3.3
ordered-speeds = order-by(flights-with-speed, "effective_speed", false)
ordered-speeds





#3.4
fastest = order-by(ordered-speeds, "effective_speed", false).row-n(0)
fastest-carrier = fastest["carrier"] 
fastest-origin = fastest["origin"] 
fastest-dest = fastest["dest"]
fastest-carrier
fastest-origin
fastest-dest





#EXERCISE 4
#4.1
# Doc: "Applies 20% discount to arr_delay if 0 ≤ arr_delay ≤ 45"
fun discount-delay(a :: Number) -> Number:
  if (a >= 0) and (a <= 45):
    a * 0.8
  else:
    a
  end
end

fun apply-arrival-discount(t :: Table) -> Table:
  transform-column(t, "arr_delay", discount-delay)
where:
  test-table = table: arr_delay
    row: -10
    row: 0
    row: 30
    row: 60
  end

  apply-arrival-discount(test-table).get-column("arr_delay") is [list: -10, 0, 24, 60]
end





#4.2

#I'M NOT SURE ABOUT THIS PART OF THE QUESTION AND THE OUTPUT !!!!

discounted = apply-arrival-discount(flights)

scored = build-column(discounted,
  "on_time_score",
  lam(r):
    dep =
      if r["dep_delay"] < 0:
        0
      else:
        r["dep_delay"]
      end

    arr =
      if r["arr_delay"] < 0:
        0
      else:
        r["arr_delay"]
      end

    score = 100 - (dep - arr) - (r["air_time"] / 30)

    if score < 0:
      0
    else:
      score
    end
  end
)





#4.3
top = order-by(order-by(scored, "on_time_score", false), "distance", true)
top





#4.4
top1 = order-by(order-by(scored, "on_time_score", false), "distance", true).row-n(0)

top2 = order-by(order-by(scored, "on_time_score", false), "distance", true).row-n(1)

carrier1 = top1["carrier"]
carrier2 = top2["carrier"]
flight1 = top1["flight"]
flight2 = top2["flight"]
origin1 = top1["origin"]
origin2 = top2["origin"]
dest1 = top1["dest"]
dest2 = top2["dest"]

carrier1
carrier2
flight1
flight2
origin1
origin2
dest1
dest2










#EXERCISE 5
#So, our current formula is:

# score = 100 - (dep_delay - arr_delay) -       (air_time / 30)

#This penalizes long flights more due to air_time / 30. Hence, for more fairness:


#So an alternative we can use instead is that we use a normalized delay ratio:

score = 100 - ((dep_delay - arr_delay) / air_time) * 60

#This scales the delay impact relative to flight duration, making short and long flights more comparable.


      
EXPLANATION, MAKE IT INTO NOTES !!:
No worries, Rajesh — let's slow it down and walk through the **alternative score formula** piece by piece. You're trying to understand this:

```text
score = 100 - ((dep_delay - arr_delay) / air_time) * 60
```

This looks confusing, but we'll break it into **four simple parts**:

---

### 🧩 1. What is `dep_delay - arr_delay`?

This measures how much **worse the departure delay was** compared to the arrival delay.

- If a flight left 60 minutes late but arrived only 30 minutes late, then:
  - `dep_delay - arr_delay = 60 - 30 = 30`
  - That means the flight **recovered 30 minutes** during the trip.

---

### 🧩 2. Why divide by `air_time`?

We want to **normalize** the delay difference by how long the flight was.

- A 30-minute recovery on a 1-hour flight is amazing.
- A 30-minute recovery on a 5-hour flight is less impressive.

So we divide by `air_time` to make the score **fair** across short and long flights.

---

### 🧩 3. Why multiply by 60?

Because `air_time` is in minutes, dividing by it gives a **per-minute ratio**. Multiplying by 60 turns it into a **per-hour penalty**, which matches the scale of the original formula.

---

### 🧩 4. What does the whole formula do?

```text
score = 100 - ((dep_delay - arr_delay) / air_time) * 60
```

- Starts with a perfect score of 100.
- Subtracts a penalty based on how inefficient the flight was.
- The penalty is **bigger** if the flight didn't recover much delay.
- The penalty is **smaller** if the flight recovered delay efficiently.

---

### ✅ Example

Let's say:
- dep_delay = 60
- arr_delay = 30
- air_time = 120

Then:

```text
score = 100 - ((60 - 30) / 120) * 60
      = 100 - (30 / 120) * 60
      = 100 - 0.25 * 60
      = 100 - 15
      = 85
```

So this flight gets a score of **85**, which is pretty good!

---

Would you like me to rewrite this explanation directly into your page so it's part of your lab notes? Or maybe visualize how scores change for short vs long flights?

      









