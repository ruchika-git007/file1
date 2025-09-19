include image
#EXERCISE 1: Writing Good Doc Strings
# Calculates the area of a rectangle given its width and height.
# Returns the product of width and height.
fun area(width :: Number, height :: Number) -> Number:
  doc: "Returns the area of a rectangle when we are given its width and height"
  width * height
end










#EXERCISE 2: The function Design Process: T-Shirt Cost
#Expressions
#Breaking the problem down we haveto calculate the Cost for 4 t-shirts with message "Go Team!"
# 4 * (5.00 + string-length("Go Team!") * 0.10)
# Cost for 7 t-shirts with message "Hello World"
#7 * (5.00 + string-length("Hello World") * 0.10)

# Defining the Magic Numbers
# I'm using "basic" for the basic cost of 1 pen and I'm using "character" for the cost that comes out of the total number of characters
basic = 5.00
character = 0.10

#Generalized Function
# Calculates the total cost of printing t-shirts with a custom message.
# Returns the total cost based on quantity and message length.
fun tshirt-cost(quantity :: Number, message :: String) -> Number:
  doc: "Returns the total cost based on quantity and message length"
  quantity * (basic + (string-length(message) * character))
end

#Rewriting Expressions Using the Function
tshirt-cost(4, "Go Team!")
tshirt-cost(7, "Hello World")










#EXERCISE 3: Function Design Process 2: Temperature Conversion of Celsius to Fahrenheit
# Converts a temperature from Celsius to Fahrenheit.
# Returns the Fahrenheit equivalent using the formula (C × 9/5) + 32.
fun celsius-to-fahrenheit(c :: Number) -> Number:
  doc: "Returns the Fahrenheit equivalent using the formula (C × 9/5) + 32."
  (c * 9/5) + 32
end


#Fahrenheit to Celsius
# Converts a temperature from Fahrenheit to Celsius.
# Returns the Celsius equivalent using the formula (F - 32) × 5/9.
fun fahrenheit-to-celsius(f :: Number) -> Number:
  doc: "Returns the Celsius equivalent using the formula (F - 32) × 5/9"
  (f - 32) * 5/9
end


#Creating Check Block
#To create check block use "check" and "end in the starting and the begginning. Then use the layout of "function name(here I need to input the celsius temperature) is "here put the output that you are supposed to get" . After doing this you can see if from the exercise you did did you get the same output.
check:
  celsius-to-fahrenheit(0) is 32
  celsius-to-fahrenheit(100) is 212
  celsius-to-fahrenheit(-40) is -40

  fahrenheit-to-celsius(32) is 0
  fahrenheit-to-celsius(212) is 100
  fahrenheit-to-celsius(-40) is -40
end










#EXERCISE 3: Creating Functions from Expressions (Image Design)
#Original Code that I had for a circle without using functions
circle(50, "solid", "red")


#Now below I created a circle with a customizable radius and color
fun circle1(radius :: Number, color :: String) -> Image:
  doc: "Returns a circle with a customizable color"
  circle(radius, "solid", color)
end


#Below I used the example with a few different examples.
circle1(50, "red")      
circle1(30, "blue")     
circle1(70, "green")    



