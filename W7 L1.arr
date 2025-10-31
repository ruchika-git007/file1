use context starter2024
#CLASSS NOTES
#|List recurssion
   We'll do 3 things today:
   1.Selection 
   2.Relaxed Domain
   3. Accumulators
   
   
   1. Selection
   fun my-pos-num(l):
   doc:"select for all positive numbers"
   
   
   
   
   
   
   
   doc:"select all other elements"
   #f => 1
   #r => [list:2, 3, 4]

   #f => 2
   #r => [list: 3,4]
   so thats how the [list:1,2,3,4] gives [list:1, 3]
   
   
|# 
   


#CLASS EXERCISES
#Strings longer than 5 characters
#If the word is longer than 5 elements we keep the word in the list.
#The goal: We want to look through a list of words and keep only the ones that are longer than 5 letters.
fun more-than-five(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if string-length(f) > 5:
        link(f, more-than-five(r))
      else:
        more-than-five(r)
      end
  end
end

check:
  more-than-five([list: "pink", "violet", "magenta"]) is ([list: "violet", "magenta"])
  
  more-than-five([list: "apple", "banana", "kiwi", "pineapple", "pear"])
  is [list: "banana", "pineapple"]

  more-than-five([list:        "banana", "kiwi", "pineapple", "pear"])
  is [list: "banana", "pineapple"]

  more-than-five([list:                 "kiwi", "pineapple", "pear"])
  is [list: "pineapple"]

  more-than-five([list:                         "pineapple", "pear"])
  is [list: "pineapple"]

  more-than-five([list:                                    "pear"])
  is [list: ]

  more-than-five([list: ])
  is [list: ]
end




#|Explanation:
- Imagine you have a line of words.
- You look at the first word (f).
- If it's longer than 5 letters, you keep it and ask the same question about the rest (r).
- If it's short or equal to 5, you skip it and move on.
- When you reach the end of the list (empty), you stop.
What does empty => empty mean?
   It's like saying: "If there's nothing left to look at, give me an empty list."|#









#Relaxed Domains : Average of a List
# defining my-average using helper functions my-sum and my-len. It raises an error on an empty list.

#my helper functions
#my-sum function, if list is empty returns 0, else takes the first element ands the sum
fun my-sum(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => f + my-sum(r)
  end
end

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
end


#my main function
fun my-average(l):
  if l == empty:
    raise("Cannot take average of empty list")
  else:
    my-sum(l) / my-len(l)
  end
end

check:
  my-average([list: 2, 4, 6, 8]) is 5
  my-average([list:    4, 6, 8]) is 6
  my-average([list:       6, 8]) is 7
  my-average([list:          8]) is 8
  my-average([list: ]) raises "Cannot take average of empty list"
end










#Accumulators: maximum using an accumulator
#defining a helper  that carries the current maximum as an accumulator.
#Defining my-max function
#Helper function

#defining my my-max function using accumulator
fun my-max-acc(current-max, l):
  cases (List) l:
    | empty => current-max
    | link(f, r) => my-max-acc(num-max(current-max, f), r)
  end
end

#main function
fun my-max(l):
  cases (List) l:
    | empty => raise("Cannot find max of empty list")
    | link(f, r) => my-max-acc(f, r)
  end
end


check:
  my-max([list: 2, 1, 4, 3, 2]) is 4
  my-max([list:    1, 4, 3, 2]) is 4
  my-max([list:       4, 3, 2]) is 4
  my-max([list:          3, 2]) is 3
  my-max([list:             2]) is 2
  my-max([list: ]) raises "Cannot find max of empty list"
end

#defining my-alternating using accumulator
#Helper function
fun my-alternating1(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      cases (List) r:
        | empty => [list: f]
        | link(fr, rr) => link(f, my-alternating1(rr))
      end
  end
where:
  my-alternating1([list: 1, 2, 3, 4, 5, 6]) is [list: 1, 3, 5]
end

#Main function 
fun my-alternating(l):
    cases (List) l:
    | empty => raise("Cannot find the alternating of the list")
    | link(fr, rr) => link(fr, my-alternating1(fr))
  end
end
check:
  my-alternating([list: 4, 5, 6, 7, 8, 9]) is [list: 4, 6, 8]
  
end



fun my-skip(l, how-many):
  m-s(0, l)
where:
  my-skip
end

fun m-s(acc,l):
  cases (List) l:
    | empty => empty
    | link(f,r)  => 