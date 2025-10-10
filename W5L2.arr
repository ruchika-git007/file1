use context dcic2024
import math as M
import statistics as S

#CLASS NOTE: A table is a compound data structure
cafe-data =
  table: day, drinks-sold
    row: "Mon", 45
    row: "Tue", 30
    row: "Wed", 55
    row: "Thu", 40
    row: "Fri", 60
  end
cafe-data
cafe-data.get-column("drinks-sold")



sales = cafe-data.get-column("drinks-sold")
#the functions below only accept lists
M.max(sales)      # maximum sales
S.mean(sales)     # average sales
M.sum(sales)      # total sold

discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

# One thing you might want to do first is figure out what are the distinct codes used:
unique-codes = distinct(discount-codes)


# We can use filter to remove codes that represent no discount (in this case, normalized "none").
fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end

real-codes = filter(is-real-code, unique-codes)

#CLASS NOTE: We use .get instead of n
real-codes.get(2)

#CLASS NOTE: using lam
map(lam(i):


#Like how tables have row-n(), lists have a way of getting an element by position:
first-code = real-codes.get(0)



#For tables, we had a few ways of transforming the existing data—adding a new column with build-column, or transforming a single column with transform-column. Since lists have only a single value, there is only one version, called map

#We can use this to, e.g., get lowercase versions of each discount code:
lower-codes = map(string-to-lower, real-codes)


#To define our own list processing functions, we need a way to do computations for each element in the list
#We will look at the for each() method today which iterates over items in a list
#This requires being able to modify variables to hold the current item in a list
#Modifiable variables must be declared with var in Pyret and should be updated with :=


#var total = 1
#total := total + 10
#total


#The template we can use for these functions looks like the following:
#fun func(lst :: List) block:
#  var result = ...  # what to return if the #input list is empty
#  for each(item from lst):
    # combine item with the result so far
#    result := ... item ... result
#  end
#  result
#end

    
    #CLASS NOTE: We use append when we want to modify a list to a NEW list   
    







#CLASS EXERCISES
#List Operations
#Using the discount codes from the intro, first apply distinct to remove duplicates, then use map with string-to-upper to convert all codes to uppercase.

#How many unique codes do you have after cleaning?
unique-codes1 = distinct(discount-codes)
upper-codes = map(string-to-upper, unique-codes1)
upper-codes




#Given this list of survey responses: [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"], use distinct and map to create a list of unique responses in lowercase. Then use filter to keep only definitive answers (filter out "maybe"). Use a lambda function with filter
survey-responses = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]
lower-responses = map(string-to-lower, survey-responses)
unique-responses = distinct(lower-responses)
unique-responses
#the lam basically means "Keep this item if it's not equal to 'maybe'."
real-answers = filter(lam(r): r <> "maybe" end, unique-responses)
real-answers









#LOOPS
#Define your own product function that takes a list of numbers and returns their product (multiply all of them together).
    #The angular brackets show the type inside the list
fun product(listt :: List<Number>) -> Number block:
  var result = 1
  for each(n from listt):
    result := result * n
  end
  result
end
Numbers1 = [list: 3, 4, 1, 8] 
product(Numbers1)
#Above I started with result = 1 because multiplying by 1 doesn't change the result.
#The for each loop goes through every number in the list (n).
#Each time, I multiply result by that number.
#When the loop ends, I return the total result.



  
  
#Define a function sum-even-numbers that takes a list of integers and adds up only the even numbers—the rest should be ignored (num-moduloLinks to an external site. may be helpful)!
fun sum-even-numbers(listt :: List<Number>) -> Number block:
  var total = 0
  for each(n from listt):
    if num-modulo(n, 2) == 0:
      total := total + n
    else:
      total := total  # do nothing (Pyret requires an else)
    end
  end
  total
end

sum-even-numbers([list: 2, 3, 4])

#num-modulo(n, 2) gives the remainder when dividing by 2.
#Even numbers → remainder 0.
#Odd numbers → remainder 1.
#If it's even, add it to total.
#If it's odd, do nothing.
#At the end, return the total sum.





#Define a function my-length that takes a list of any value and returns the number of elements in the list.
fun my-length(listt :: List<Any>) -> Number block:
  var counter = 0
  for each(_ from listt):
    counter := counter + 1
  end
  counter
end

my-length([list: "a", "b", "c"])
#Start a counter at 0.
#The underscore _ means "I don't care what the item is — just count it."
#For each item in the list, add 1 to the counter.
#Return the counter.





#Design a function my-doubles that takes a list of numbers and returns a new list where each element is twice what the corresponding element was in the original list.
fun my-doubles(lst :: List<Number>) -> List<Number> block:
  var result = [list: ]
  for each(n from lst):
    result := result + [list: n * 2]
  end
  result
end

list2 = [list: 3, 8, 7, 1]
my-doubles(list2)
# I Start with an empty list result.
#For each number n in the list:
#Create a tiny list [list: n * 2].
#Add that small list to the result list.
#Return the full result.





#Re-implement the same function as my-doubles-map using map from the lists library. Which implementation do you find clearer?
fun my-doubles-map(lst :: List<Number>) -> List<Number>:
  map(lam(n): n * 2 end, lst)
end

list3 = [list: 3, 8, 7, 1]
my-doubles-map(list3)
#I find the second implementation more clearer

#map() already loops through the list for you.
#The lambda lam(n): n * 2 end tells Pyret what to do for each item.
#So it's the same result as before, but with one simple line.





#Design my-string-lens which takes a list of strings and returns a new list where each element is the length of the string in the corresponding position in the input list.
fun my-string-lens(lst :: List<String>) -> List<Number> block:
  var result = [list: ]
  for each(s from lst):
    result := result + [list: string-length(s)]
  end
  result
end

list4 = [list: "pink", "purple", "violet", "indigo", "crimson"]
my-string-lens(list4)
#For every string s in the list, find its string-length.
#Then Add that number to the new list.





#Re-implement the same function as my-string-lens-map using map from the lists library. Which implementation do you find clearer?
fun my-string-lens-map(lst :: List<String>) -> List<Number>:
  map(string-length, lst)
end

list5 = [list: "pink", "purple", "violet", "indigo", "crimson"]
my-string-lens-map(list4)

#I find the my-string-lens-map more clearer as it's a shorter block of code which is easier to read
#Same thing as before, but map applies string-length to each word automatically.





#Design my-alternating, which takes a list of any element and returns a new list that contains every other element—i.e., keep the first, skip the second, etc. Note: you may need two mutable variables for this one—one to contain the result, as normal, but the other to keep track of the alternation.
fun my-alternating(lst :: List) -> List block:
  var result = [list: ]
  var index1 = 0
  for each(item from lst) block:
    if num-modulo(index1, 2) == 0:
      result := result + [list: item]
    else:
      result :=result
    end
    index1 := index1 + 1
  end
  result
end

list6 = [list: "a", "b", "c", "d", "e"]
my-alternating(list6)

#I started with an empty result list.
#Then I kept track of where I was in the list using index1.
#For each item:

#If the index is even (0, 2, 4, ...), keep it.

#If it's odd (1, 3, 5, ...), skip it.
#Remember that num-modulo finds the remainder, example: num-modulo(5,2) = 1
#Increase the index by 1 each time.
#Return the result list.







    #Array, recurssion, data definitions
    #In array we use striding
