
#LECTURE NOTES
#|Examples
Written examples help us figure what a function needs to do
Help us make sure that we understand the problem
Provide guidance for someone else reading our code to know what to expect
Examples are a nice intermediate point before writing code.
You can sketch out the relevant computation on concrete values first, then worry about turning it into a function.
If you can't write the examples, chances are you won't be able to write the function either.
Examples break down the programming processLinks to an external site. into smaller, manageable steps.|#




#Pyret provides us with a tool for looking at the inside of program called spy.
#Spy allows us to see expressions as code is running.
#The simplest form is to give it the names of identifiers, i.e.:
   
   
   
   
#|If/Else and Ask Expressions
When you want to have multiple branches in your conditionals, you can use else if
if x == 0:
  1
else if x > 0:
  x * 2
else:
  x * -1
end
Ask ExpressionsLinks to an external site. are a slightly different way to write else if expressions which make them easier to read
Branches are separated by the | pipe character
   The default condition is written as otherwise: 
ask:
  | x == 0 then: 1
  | x > 0 then: x * 2
  | otherwise: x * -1
end            |#








#choose-hat function
#fun choose-hat(temp-in-C :: Number) -> String:
#  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing"
#  if temp-in-C > 27:
#    "sun hat"
#  else:
#    "no hat"
#  end
#where:
#  choose-hat(25) is "no hat"
#  choose-hat(32) is "sun hat"
#  choose-hat(27) is "sun hat"
#end





#Add another possibility to choose-hat, that if the temperature is below 10, you choose a winter hat. Any time you are changing code, you should revisit each step of the design recipe, in order, and change as appropriate (type signature, doc string, tests, code).

# USING IF/ELSE IF EXPRESSIONS
fun choose-hat(temp-in-C :: Number) -> String:
  doc: "Returns appropriate head gear, winter hat if below 10°C, sun hat if above 27°C, otherwise no hat"
  if temp-in-C < 10:
    "winter hat"
  else if temp-in-C > 27:
    "sun hat"
  else:
    "no hat"
  end
where:
  choose-hat(5) is "winter hat"
  choose-hat(32) is "sun hat"
  choose-hat(20) is "no hat"
end

#Using ASK expression
#The AK works in the same way, except we give all 3 things that we need in the where block.
fun choose-hat1(temp-in-C :: Number) -> String:
  doc: "Returns appropriate headwear using ask: winter hat if below 10°C, sun hat if above 27°C, otherwise no hat"
  ask:
    | temp-in-C < 10 then: "winter hat"
    | temp-in-C > 27 then: "sun hat"
    | otherwise: "no hat"
  end
where:
  choose-hat1(5) is "winter hat"
  choose-hat1(32) is "sun hat"
  choose-hat1(20) is "no hat"
end





#Now imagine you got new sunglasses, and want to design a function add-glasses that takes an outfit (as a string) and always adds ", and glasses" to what you will wear.
fun add-glasses(outfit :: String) -> String:
  doc: "Adds glasses to any outfit as a string"
  outfit + ", and glasses"
where:
  add-glasses("sun hat") is "sun hat, and glasses"
  add-glasses("no hat") is "no hat, and glasses"
end





#Let's now design a new function, choose-outfit, that takes as input the temperature in celsius, and uses the two functions you just wrote to compute a final outfit. There are at least two ways of doing this—one defines a new local name with the result of calling choose-hat, and the other directly passes the result of calling choose-hat to add-glasses.

#ption 1: Using a Local Name
fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "computes final outfit with hat and glasses based on temperature"
  block:
    headwear = choose-hat(temp-in-C)
    add-glasses(headwear)
  end
end
#- This version stores the result of choose-hat(temp-in-C) in a local name headwear
#- Then passes it to add-glasses






#Option 2: using Direct Function composition
  fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "Directly passes result of choose-hat to add-glasses"
  add-glasses(choose-hat(temp-in-C))
end
#- This version skips the local name and directly pipes the result of choose-hat into add-glasses




  
  
  
  
#Now, add a new function choose-hat-or-visor that takes not only a temp-in-C, but also an additional argument, has-visor, which is a boolean that indicates whether the person owns a visor.
#Using 2 conditions for if there are 2 conditions. First condition is that the temperature has to be greater than 30. Then, the second condition is that the has-visor has to be true. Both conditions have to be true for the if function. Else what we will do, is choose the temp-in-C.
fun choose-hat-or-visor(temp-in-C :: Number, has-visor :: Boolean) -> String:
  doc: "Returns visor if temp > 30 and has-visor is true, otherwise uses choose-hat"
  if (temp-in-C > 30) and (has-visor == true):
    "visor"
  else:
    choose-hat(temp-in-C)
  end
where:
  choose-hat-or-visor(32, true) is "visor"
  choose-hat-or-visor(32, false) is "sun hat"
  choose-hat-or-visor(5, true) is "winter hat"
end



#|Wrap-up - Full Design Recipe
There is a useful order we should carry out writing new functions, and we can make this concrete as a Design Recipe for functions:

1. Type Annotation
Once we have decided we need to write a function, the first thing we should think about, assuming we were not told it, is what type of inputs the function should take and what type of output it should produce. While we introduced type annotations as a way to get better error messages, and indeed they are, this use as part of a design process is indeed much more important: it helps us organise our thoughts!

2. Doc String
After figuring out the types of data the function operates over, it is worth writing down what the function should do! This is in English, and it doesn't need to include how the function works (and usually shouldn't)—the purpose of the explanation is so that someone can understand how to use the function, not how it works internally. While this serves as useful documentation, it is even more useful as part of a design process, since like type annotations, it helps us organize our thoughts—in particular, it makes us think a little bit more concretely about how the code should work—i.e., how is the output constructed from the input.

3. Tests
The third step is writing tests is a where block—these examples serve as the most concrete step of our design process, as its the point where we think through concrete cases of inputs, and exactly the output they should produce. It may be, as we write them, that we realise we did not think of something in the earlier steps, which is fine—we go back and fix those and then continue forward. In addition to forming a useful step in the design process, these tests will also be used to check that our function works as expected!

4. Code
The last step, which we should only do after the first three, is writing down the code. There is a strong tendency for students, especially beginners, to want to jump ahead—but the clarity that comes from doing the earlier steps will make writing the code easier, to the point that it is faster to not skip ahead.|#