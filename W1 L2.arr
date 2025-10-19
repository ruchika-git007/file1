use context starter2024

#LECTURE NOTES
#string-length(s) returns the number of characters
#string-repeat(s, n) repeats string s, n number of times

#We can create basic shapes with functions like circle, rectangle, triangle
#circle(30, "solid", "blue")
#rectangle(40, 20, "solid", "green") #length, width
#triangle(50, "outline", "red")


#There are operations on images:
#overlay(i1,i2) creates a new image that has the first image on top of the second
#above(i1,i2) composes the images by creating a new image with i1 on top of i2
#below(i1,i2) composes images with i1 below i2

i1 = circle(20, "solid", "red")
i2 = rectangle(40, 10, "solid", "yellow")
below(i1, i2)

#|Further, operations have types that they take in, and types that they produce. These are usually written down in the documentation as contracts, with ::, e.g.:
* :: (Number, Number) -> Number
   circle :: (Number, String, String) -> Image |#










#CLASS EXERCISES

#Turn a string to all uppercase
string-to-upper("hello cs2000!")





#Create a blue circle and a yellow rectangle, then overlay them (circle on top)
overlay(circle(50, "solid", "blue"),
  rectangle(100, 100, "solid","yellow"))






#Stack a green rectangle above a purple rectangle
above(rectangle(100, 50, "solid", "green"), rectangle(100, 50, "solid", "purple"))





#Rotate a red rectangle (100 wide × 20 tall) in two different ways
rotate(45, rectangle(100, 20, "solid", "red"))
rotate(90, rectangle(100, 20, "solid", "red"))
#|rotate :: (
angle :: Number,
img :: Image
)
   -> Image|#




#Create a Stop sign using text and regular-polygon
overlay(overlay(overlay(
      text("STOP", 35, "white"),
  regular-polygon(40, 8, "solid", "red")
    ),
    regular-polygon(45, 8, "solid", "white")),
  regular-polygon(49, 8, "outline", "black"))





#Create another image of your choice 
#I'm creating a ROBOT face)
# Head base
head = rectangle(120, 120, "solid", "gray")

# Eyes
eye = circle(15, "solid", "black")
eyes = beside(eye, eye)

# Mouth
mouth = rectangle(80, 10, "solid", "red")

# Face layout
face = above(eyes, mouth)

# Combine face with head
robot = overlay(face, head)

# Add a label
labeled = above(text("ROBO", 20, "white"), robot)

labeled











