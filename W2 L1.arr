include image

#LECTURE NOTES
#The LHS pane is the DEFINITIONS pane
#The RHS pane is the INTERACTIONS pane
#|Definitions vs Interactions
We have used the definitions window to write down expressions, and see them printed out when we hit Run
The interactions window can be used to access expressions we have defined
Running caused everything in the definitions pane to evaluate, including the rectangle expression above, which evaluated to a blue square.
The definition statement blue-square = ... caused the resulting value to be stored under that name so we can refer to it later.|#

#NOTE: Pyret stores definitions inside an internal directory (that we cannot see) which associates names with values

#Every definition statement, written name = expression causes expression to be evaluated and name to be added to the directory, so it can be used later, including in other expressions for other definitions.
#e.g., you can write radius = 10 and then area = 3.14 * radius * radius. If you do those in the other order, it won't work, since the directory won't have the radius entry yet.

#In Pyret, = denotes definition not assignment, it defines a name for a value. We read radius = 10 as radius is defined to be 10. By default, definitions are immutable, not mutable boxes for storing values.

#Names & strings are different! "blue-square" is not the same as blue-square. What do you think will happen if you type puppy versus "puppy" at the prompt?

#Redefining the same variable is called shadowing, and Pyret rules this out, since it is a common cause of bugs.









#CLASS EXCERCISES
#Excercise 1
orange-triangle = triangle(35, "solid", "orange")
orange-triangle
#


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
