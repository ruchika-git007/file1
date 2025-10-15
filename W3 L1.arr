
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


  #using Direct Function composition
  fun choose-outfit(temp-in-C :: Number) -> String:
  doc: "Directly passes result of choose-hat to add-glasses"
  add-glasses(choose-hat(temp-in-C))
end

  
  
  
  
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

