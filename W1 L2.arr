use context starter2024

#W1 L2
#CLASS EXERCISES


#Turn a string to all uppercase
string-to-upper("hello cs2000!")





#Create a blue circle and a yellow rectangle, then overlay them (circle on top)
overlay(circle(50, "solid", "blue"), rectangle(100, 100, "solid", "yellow"))






#Stack a green rectangle above a purple rectangle
above(rectangle(100, 50, "solid", "green"), rectangle(100, 50, "solid", "purple"))





#Rotate a red rectangle (100 wide × 20 tall) in two different ways
rotate(45, rectangle(100, 20, "solid", "red"))
rotate(90, rectangle(100, 20, "solid", "red"))





#Create a Stop sign using text and regular-polygon
overlay(
  text("STOP", 30, "white"),
  regular-polygon(8, 60, "solid", "red")
)





#Create another image of your choice (example: ROBOT face)
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
labeled = above(text("ROBO", 20, "blue"), robot)

labeled











