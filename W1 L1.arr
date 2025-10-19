
#CLASS EXERCISE 1
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
