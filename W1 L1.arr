#LECTURE NOTES

#Pyret requires spaces around operators: 2 + 3 not 2+3.
#Pyret requires use of parenthesis to disambiguate operators. (2 + 3) * 4 vs. 2 + (3 * 4). Note what happens if you write 2 + 3 * 4, WE GET ERROR.




#Comments in Pyret
#Pyret supports two forms of comments
#Single-line comments begin with a # symbol and extend to the end of the line:
# This is an example of a single-line, standalone comment
3 + 5
#Block comments begin with a #| symbol and end with a matching |#
#|
   This comment can extend
   over multiple lines
|#
3 + 10

#Example:
#Hey my name is Ruchika and I study at Northeastern University (Single-line Comment)
#|Hey my name is Ruchika
   and I study at Northeastern University|#       #Block Comment





#CLASS EXERCISES
#Calculate the area of a rectangle with length 10 and width 3.
10 * 3


#Calculate its perimeter.
(10 * 2) + (3 * 2)


#Note that many different expressions can produce the same value. Come up with three different expressions that all evaluate to the value 10.
5 + 5
(2 * 2) + (3 * 2)
5 * 2


#Read the beginning of the Pyret Numbers documentationLinks to an external site. on ExactNums vs RoughNums, and then look at some of the functions below
#Unlike operators, a function, e.g., num-max, when applied to two numbers, is written num-max(10, 20).
#Come up with an expression that uses only ExactNums, but produces a RoughNum when evaluated.
num-sin(1)
#Hence num-sin uses an ExactNum which is 1 and when you run it, it shows ~0.8414709848078965 which is a RoughNum.
#In Pyret, RoughNums are floating-point approximations, and they're always displayed with a tilde (~) prefix. That tilde is your giveaway.
