use context starter2024
#LAB 3
#SAMPLE SOLUTIONS

#PROBLEM 1
fun leap-year(year :: Number) -> Boolean:
  doc: "returns true if year is a leap year"   
  if num-modulo(year, 400) == 0:
    true
  else if num-modulo(year, 100) == 0:
    false
  else if num-modulo(year, 4) == 0:
    true
  else:
    false
  end
where:
  leap-year(2012) is true
  leap-year(1900) is false
  leap-year(2025) is false
end





#PROBLEM 2
fun tick(seconds :: Number) -> Number:
  doc: "returns the next second of a given second"
  if seconds < 59 :
    seconds + 1
  else: 
    0
  end
where:
  tick(10) is 11
  tick(59) is 0
  tick(0) is 1
end





#PROBLEM 3
fun rock-paper-scissors(p1 :: String, p2 :: String) -> String:
  doc: "returns the winner of a rock paper scissors game"
  ask:
    | (p1 == p2) then: "tie"
    | (p1 == "rock") and (p2 == "scissors") then: "player 1"
    | (p1 == "rock") and (p2 == "paper") then: "player 2"
    | (p1 == "paper") and (p2 == "rock") then: "player 1"
    | (p1 == "paper") and (p2 == "scissors") then: "player 2"
    | (p1 == "scissors") and (p2 == "paper") then: "player 1"
    | (p1 == "scissors") and (p2 == "rock") then: "player 2"
    | otherwise: "invalid choice"
  end
where:
  rock-paper-scissors("scissors", "rock") is "player 2"
  rock-paper-scissors("rock", "paper") is "player 2"
  rock-paper-scissors("rock", "rock") is "tie"
end





#PROBLEM 4
planets = table: planet :: String, distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end

mars = planets.row-n(3)
mars["distance"]





#PROBLEM 5
use context dcic2024
include csv
include data-source

boe-rates = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end

boe-rates.length()
median(boe-rates, "rate")
mean(boe-rates, "rate")
order-by(boe-rates, "rate", true)
