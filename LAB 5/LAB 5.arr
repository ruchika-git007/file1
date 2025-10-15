use context dcic2024
include csv
include tables
include data-source

#TASK 1
flights_samples = load-table:
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

flights_samples





#TASK 1
#STEP 1

#Problem: The carrier column has inconsistent formatting (extra spaces, lowercase letters).
#Planned Step: "Clean the carrier column by trimming spaces and converting text to uppercase."

#Implementation: Use transform-column with a lambda that applies trim and string-to-upper to each value.



#STEP 2
#Problem: The tailnum column has blank cells with missing values.
#Planned Step: "Fill the tailnum column by filling the blank cells."

#Implementation: 
 




#TASK 2
#2.1
# bonus-scores = transform-column(students,  "score", add-bonus)
#fun replace-space(a :: string):
#  if a = "" :
#   a = "UNKNOWN"
#  else:
#    a = a
#  end
#end
#replaced = transform-column(flights_samples, "tailnum", replace-space)
  



#2.2
fun clean-delays(a :: Number) -> Number:
  if a < 0:
    0
  else:
    a
  end
end

flights-cleaned = transform-column(
  transform-column(flights_samples, "dep_delay", clean-delays),
  "arr_delay", clean-delays
)

flights-cleaned




#2.3
#dedup_key = "flight" + "carrier" + "dep_time"
#fun concatinator(a :: Number, b :: String):
# a = r["flight"]
# b = r["carrier"]
#  string-append(a, b)
#end


#joined1 = build-column(flights_samples, "dedup_key", concatinator ) 



#2.4
#3.1
converted = string-to-number("flight")


#3.2
# Trim spaces at both ends
fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    string-replace(s, " ", "")
  end
end

trim("carrier")




#3.3
#517 = dep_time
#hour = num-flour(517/100) gives 5
#min = num-modulo(517,100) gives 17

hour = num-floor(517 / 100)
min = num-modulo(517, 100)

fun final1(a :: Number):
  if a < 10:
    0 + a
  else:
    a
  end
end

final1(hour)


#grouping and counting duplicate entries
grouped = group(flights_samples, "dedup_key")
counted = count(flights_samples, "dedup_key")
grouped
counted





#TASK 3
fun added-airlines(carrier :: String):
  if carrier = "UA":
    "United Airlines"
  else if carrier = "AA":
    "American Airlines"
  else if carrier = "B6"
    "Jet Blue"
    else if carrier = "DL":
    "Delta Airlines"
    else if carrier = "EV":
    "Express Jet"
  else if carrier = "WN":
    "Southwest Airlines"
  else if carrier = "OO":
    "Southwest Airlines"
  else:
    "Other"
  end
end


build-column(flights_samples, "airlines", added-airlines)




#3.2
filtered-outliers = filter-with(filter-with(flights_samples, lam(r): r["distance"] > 5000 end), lam(r): r["air_time"] < 500))





#TASK 4
#4.1