include image

#CLASS NOTES
#FUNCTIONS
#Functions allow us to express repeated expressions that differ in some way.
#I can write a function that says "Welcome to class, " and then someones name, and then use it for many different people:
fun welcome(name :: String) -> String:
  doc: "returns a greeting addressed to the given person"
  "Welcome to class, " + name
end
#REMEBER: We're passing the name as an input here.
welcome("Sabrina")
#NOTE : All functions should have type annotations


#Functions can accept multiple arguments:
fun area1(width, height):
  width * height
end

check:
  area1(3, 20) is 3 * 20
  area1(4, 50) is 4 * 50
end
#using check blocks










# NOTE : ALWAYS PUT:
# TYPE ANNOTATIONS
# DOCSTRINGS (documentation string)
#A docstring is a concise, English explanation of what the purpose of the function is
#Not necessarily how it works (though the distinction is subtle), but what someone who wants to use it needs to know.
#CHECKS
#|Checks
We can check that a function works properly. in Pyret using check blocks
This is also known as a test
Check blocks are named units of tests containing test operators
A simple check can be written using testing operatorsLinks to an external site.
You can integrate tests inside functions as examples using a where block, more on this in the next lecture
check:
  welcome("Max") is "Welcome to class, Max"
  welcome("Franz") is "Welcome to class, Franz"
   end|#




#Creating Functions From Expressions
#If we have multiple concrete expressions that are identical except for a couple of specific data values, we create a function with the common code as follows:
#Write at least two expressions showing the desired computation, example:


armenia = frame(
  above(rectangle(120, 30, "solid", "red"),
    above(rectangle(120, 30, "solid", "blue"),
      rectangle(120, 30, "solid", "orange"))))
armenia
austria = frame(
  above(rectangle(120, 30, "solid", "red"),
    above(rectangle(120, 30, "solid", "white"),
      rectangle(120, 30, "solid", "red"))))
austria
#btw frame just adds a black frame to the image, this is how frame works:
# frame :: (img :: Image)-> Image

#Identify which parts are fixed and give names to the parts that change
#|frame(
  above(rectangle(120, 30, "solid", top),
    above(rectangle(120, 30, "solid", middle),
      rectangle(120, 30, "solid", bottom)))) |#
#As you can see above the top, middle and bottom are changing.(colours are changing)


#Name the function something suggestive and write the syntax for functions around the expression
#|fun three-stripe-flag(top, middle, bot):
  frame(
    above(rectangle(120, 30, "solid", top),
      above(rectangle(120, 30, "solid", middle),
        rectangle(120, 30, "solid", bot))))
   end |# 


#Add types for the parameters and output
#We now have an abstract representation of a three stripe flag
fun three-stripe-flag(
    top :: String, 
    middle :: String, 
    bot :: String
  )
  -> Image:
  doc: "returns a flag with three stripes"
  frame(
    above(rectangle(120, 30, "solid", top),
      above(rectangle(120, 30, "solid", middle),
        rectangle(120, 30, "solid", bot))))
end
check:
  three-stripe-flag("red", "blue", "orange") is armenia
  three-stripe-flag("red", "white", "red") is austria
end



#We can use the function by calling its name
three-stripe-flag("red", "blue", "orange")
three-stripe-flag("red", "white", "red")
#We can use a check block to test its expected behaviour (more in the next lecture)
check:
  three-stripe-flag("red", "blue", "orange") is armenia
  three-stripe-flag("red", "white", "red") is austria
end




#How can we allow the flag dimensions to be customised? Do we need the width and height, or could it be a proportion of one value?

#Option 1: Explicit Width and Stripe Height
fun three-stripe-flag1(
    top :: String,
    middle :: String,
    bot :: String,
    width :: Number,
    stripe-height :: Number
  ) -> Image:
  doc: "returns a flag with three stripes of given width and stripe height"
  frame(
    above(rectangle(width, stripe-height, "solid", top),
      above(rectangle(width, stripe-height, "solid", middle),
        rectangle(width, stripe-height, "solid", bot))))
end

#Option 2: Width and Total Height (auto-divide into thirds)
fun three-stripe-flag2(
    top :: String,
    middle :: String,
    bot :: String,
    width :: Number,
    total-height :: Number
  ) -> Image:
  doc: "returns a flag with three equal stripes based on total height"
  block:
    stripe-height = total-height / 3
    frame(
      above(rectangle(width, stripe-height, "solid", top),
        above(rectangle(width, stripe-height, "solid", middle),
          rectangle(width, stripe-height, "solid", bot))))
  end
end



#|Why are we using block ?
In Pyret, a `block:` is used to group multiple expressions together in a function body, especially when you want to **define intermediate values** before returning a final result.

### ✅ What `block:` Does

It lets you:
- Declare local variables using `name = expression`
- Use those variables in later expressions
- Return the final result as the last expression in the block

---

### 🔍 In Your Example:

```pyret
fun three-stripe-flag(top :: String, middle :: String, bot :: String, width :: Number, total-height :: Number) -> Image:
  doc: "returns a flag with three equal stripes based on total height"
  block:
    stripe-height = total-height / 3
    frame(
      above(rectangle(width, stripe-height, "solid", top),
        above(rectangle(width, stripe-height, "solid", middle),
          rectangle(width, stripe-height, "solid", bot))))
  end
end
```

- `stripe-height = total-height / 3` is a local definition
- The final expression (the `frame(...)`) is the return value of the block
- The `block:` groups these together so Pyret knows they belong to the same scope

---

### 🧠 Without `block:`, this would fail:
You can't just write `stripe-height = ...` inside a function unless it's inside a `block:` — Pyret requires that kind of scoping for intermediate values.|#








#CLASS EXERCISES
#EXERCISE 1: Writing Good Doc Strings
#For a good doc string it should say "returns"
# Calculates the area of a rectangle given its width and height.
# Returns the product of width and height.
fun area(width :: Number, height :: Number) -> Number:
  doc: "Returns the area of a rectangle when we are given its width and height"
  width * height
end


area(6, 2)







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
#So the 2 magic numbes are the base cost(5) and the cost per character(0.10).
#|✅ Why Naming Magic Numbers Matters
- It makes your code self-documenting.
- It avoids confusion when values change later.
   - It helps with maintainability and readability.

✅ What Counts as a "Magic Number"?
A magic number is any literal number in your code that:
- Appears without explanation
- Has a specific meaning or role
- Could change in the future
   - Isn't immediately clear to someone reading the code|#





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


#NOTE: Use this new function to recreate your original image and some variations. Notice how much easier it is to read even though the behaviour is the same: this is your second example of Design—just like constant definitions can make expressions easier to read or give meaning to numbers, by splitting large expressions into smaller parts, functions give names to repeated computations.


#|Wrap-up
Functions allow us to not repeat ourselves; more importantly, they are our first, and in this class, primary, example of a mechanism for abstraction
i.e., building a re-usable piece of a program, that has internals that are not visible to other parts of the program. - Abstraction is one of, if not the most, important ideas in computer science.
Type annotations serve as a form of documentation to explain what kind of input each parameter expects.
Docstrings communicate what the function does, in a clear, simple way.
Type annotations and docstrings serve both as a guide to others, but more importantly, as a guide for you
Thinking through the inputs/outputs before writing the function, and describing what the function should do, helps you figure out how to implement it. |#


