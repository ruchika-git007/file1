include image

overlay(
  text("STOP", 25, "white"),
overlay(
  regular-polygon(35, 8, "solid", "red"),
  regular-polygon(40, 8, "solid", "white")
    )
  )


#LAB 1:
#Excercise 1: Calculating costs
price_1 = 3 + (12 * 5)
price_1
price_2 = 3 + (12 * 7)
price_2
# Excercise 2: Rectangular Poster
perimeter = 2 * (420 + 594)
perimeter * 0.10
#If I forget parenthesis around (width + height) then I get an error

#Exercise 2: String Surprises
"Designs for everyone!"
#If I omit the quotes it shows an error
#Excercise: Colpur inventory
"red" + "blue"
# If I try 1 + "blue" this gives me an error as it's combining a string with a number.

#EXERCISE 3: Making a Traffic Light
 
overlay-xy(
above(
    circle(20, "solid", "red"),
  above(
      circle(20, "solid", "yellow"),
      circle(20, "solid", "green")
  )
    ), 0, 0, rectangle(40, 100, "solid", "black")
  )




 
overlay-xy(
above(
    circle(20, "solid", "red"),
  above(
      circle(20, "solid", "yellow"),
      circle(20, "solid", "green")
  )
    ), 0, 0, rectangle(40, 100, "solid", "black")
  )

#EXCERCISE 4: BROKEN CODE HUNT

# Goal: A rectangle with width 50 and height 20, solid black
rectangle(50, 20, "solid", "black")
circle(30, "solid", "red")

#Excercise 5: Making Flag
above(
  rectangle(180, 60, "solid", "red"),
  above(
    rectangle(180, 60, "solid", "blue"),
    rectangle(180, 60, "solid", "orange")
  )
)
  

#Shield Variation
overlay(text("Go!", 30, "black"),
overlay(
  star(20, "solid", "fire-brick"),
  overlay(
    circle(20, "solid", "white"),
    circle(30, "solid", "grey")
  )
)
  )


  