include image

#CLASS EXCERCISES
#Excercise 1
orange-triangle = triangle(35, "solid", "orange")
orange-triangle



#Excercise 2
side-length = 40
square-color = "blue"
blue-square = square(side-length, "solid", square-color)
blue-square



#Excercise 3
square(40, "solid", "blue")


#When re-defining a variable which is known as shadowing, pyret gives an error so we cant redefine things


#Putting yellow circle on top of rectangle
circle-radius = 10
circle-color = "yellow"
rect-width = 100
rect-height = 50
rect-color = "black"

yellow-circle = circle(circle-radius, "solid", circle-color)
black-rectangle = rectangle(rect-width, rect-height, "solid", rect-color)

circle-on-rectangle = overlay(yellow-circle, black-rectangle)
circle-on-rectangle



#Two Yellow Circles Side-by-Side on a Black Rectangle
yellow-circle1 = circle(10, "solid", "yellow")
black-rectangle2 = rectangle(100, 50, "solid", "black")

two-circles = beside(yellow-circle1, yellow-circle)
circles-on-rectangle = overlay(two-circles, black-rectangle2)
circles-on-rectangle

# 9. Designing a Simple Flag or Logo
#My flag has:
#- A red background
#- A white star in the center
#- Two blue stripes at the top and bottom
flag-width = 200
flag-height = 100
bg-color = "red"
stripe-color = "blue"
star-color = "white"

background = rectangle(flag-width, flag-height, "solid", bg-color)
top-stripe = rectangle(flag-width, 10, "solid", stripe-color)
bottom-stripe = rectangle(flag-width, 10, "solid", stripe-color)
starr = star(20, "solid", star-color)

flag = overlay(
  starr,
  overlay(
    above(top-stripe, above(background, bottom-stripe)),
    background
  )
)
flag
