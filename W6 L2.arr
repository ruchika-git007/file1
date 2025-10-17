use context dcic2024
include data-source
#W6 L2

#CLASS EXERCISES
#SCALAR PROCESSING: STRING CONCATANATE
#Design a function called string-concat that takes a list of strings and joins them all together into a single string.
#Develop your examples first

#My examples:
#string-concat([list: "a", "b", "c"]) is "abc"
#string-concat([list: "hello", " ", "world"]) is "hello world"
#string-concat([list: ]) is ""


#Designing my function
fun string-concat(l :: List<String>) -> String:
  cases (List) l:
    | empty => ""
    | link(f, r) => f + string-concat(r)
  end
where:
  string-concat([list: "a", "b", "c"]) is "abc"
  string-concat([list: "hello", " ", "world"]) is "hello world"
  string-concat([list: ]) is ""
end





#List Transformation: Strings Upper
#Design a function called strings-upper which, given a list of strings returns a list of strings with all the values upper-case
#Develop your examples first

#My examples:
#strings-upper([list: "a", "b", "c"]) is [list: "A", "B", "C"]
#strings-upper([list: "hello", "world"]) is [list: "HELLO", "WORLD"]
#strings-upper([list: ]) is [list: ]

fun strings-upper(l :: List<String>) -> List<String>:
  cases (List) l:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), strings-upper(r))
  end
where:
  strings-upper([list: "a", "b", "c"]) is [list: "A", "B", "C"]
strings-upper([list: "hello", "world"]) is [list: "HELLO", "WORLD"]
strings-upper([list: ]) is [list: ]
end





#List Transformation: Rounding
#Design a function called round-numbers which, given a list of decimal (floating-point) numbers, returns a list with each number rounded to the closest integer.
#Develop your examples first
#Ensure that you add a parametric annotation to the function so that it can only be given lists of numbers

#My examples:
#round-numbers([list: 1.2, 3.7, 4.5]) is [list: 1, 4, 4]
#round-numbers([list: ]) is [list: ]

#My functions (I created 2 functions, A function to round and a function to round numbers in the list)
fun round(n :: Number) -> Number:
  if (n - num-floor(n)) < 0.5:
    num-floor(n)
  else:
    num-ceiling(n)
  end
end


fun round-numbers(l :: List<Number>) -> List<Number>:
  cases (List) l:
    | empty => empty
    | link(f, r) => link(round(f), round-numbers(r))
  end
where:
  round-numbers([list: 1.2, 3.7, 4.5]) is [list: 1, 4, 5]
  round-numbers([list: ]) is [list: ]
end
