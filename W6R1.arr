use context dcic2024
#W6R1

#CLASS NOTES

















#CLASS EXERCISES
#TASK PLANNER
# First, define Priority
#defining priority first to do part 2 of first exercise
data Priority:
  | low
  | medium
  | high
end

# Then define Status
data Status:
  | todo
  | in-progress
  | done
end

# Now define Task, which uses both Priority and Status
data Task:
  | task(description :: String, priority :: Priority, status :: Status)
  | note(description :: String)
end




#MODIFYING THE DESCRIBE FUNCTION
fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p, s) =>
      priority = cases (Priority) p:
        | low => "❕"
        | medium => "❗️"
        | high => "‼️"
      end
      status = cases (Status) s:
        | todo => " [TODO]"
        | in-progress => " [IN-PROGRESS]"
        | done => " [DONE]"
      end
      priority + "TASK: " + d + status
    | note(d) => "📝 " + d
  end
end

# Cross-checking:
task-1 = task("Buy groceries", low, todo)
task-2 = task("Pay council tax", high, done)
note-1 = note("Post Office closes at 4:30")

describe(task-1)  # ❕TASK: Buy groceries [TODO]
describe(task-2)  # ‼️TASK: Pay council tax [DONE]
describe(note-1)  # 📝 Post Office closes at 4:30










#TEMPERATURE
#designing a data definition
data Temperature:
  | celcius(degrees :: Number)
  | fahrenheit(degrees :: Number)
  | kelvin(degrees :: Number)
end





#Creating to-celsius function
fun to-celcius(t :: Temperature) -> Number:
  cases (Temperature) t:
    | celcius(d) => d
    | fahrenheit(d) => (d - 32) * (5 / 9)
    | kelvin(d) => d - 273.15
  end
end

# Cross checking:
to-celcius(celcius(25))      # 25
to-celcius(fahrenheit(98.6)) # ~37
to-celcius(kelvin(300))      # ~26.85










#WEATHER REPORT
#defining Weather report data with the following variants
data WeatherReport:
  | sunny(temp :: Temperature)
  | rainy(temp :: Temperature, precipitation :: Number)
  | snowy(temp :: Temperature, precipitation :: Number, wind :: Number)
end



#Making is-severe function
fun is-severe(wr :: WeatherReport) -> Boolean:
  cases (WeatherReport) wr:
    | sunny(temperature) => to-celcius(temperature) > 35
    | rainy(temperature, precipitation) => precipitation > 20
    | snowy(temperature, precipitation, wind) => wind > 30
  end
end

# Cross checking:
is-severe(sunny(celcius(36)))               #should be true
is-severe(rainy(fahrenheit(60), 25))        #should be true
is-severe(snowy(kelvin(270), 10, 35))       #should be true
is-severe(snowy(celcius(0), 5, 20))         #should be false



