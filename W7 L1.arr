use context starter2024



#CLASS EXERCISES
#Strings longer than 5 characters
#The goal: We want to look through a list of words and keep only the ones that are longer than 5 letters.
fun longer-than-five(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if string-length(f) > 5:
        link(f, longer-than-five(r))
      else:
        longer-than-five(r)
      end
  end
end

check:
  longer-than-five([list: "apple", "banana", "kiwi", "pineapple", "pear"])
  is [list: "banana", "pineapple"]

  longer-than-five([list:        "banana", "kiwi", "pineapple", "pear"])
  is [list: "banana", "pineapple"]

  longer-than-five([list:                 "kiwi", "pineapple", "pear"])
  is [list: "pineapple"]

  longer-than-five([list:                         "pineapple", "pear"])
  is [list: "pineapple"]

  longer-than-five([list:                                    "pear"])
  is [list: ]

  longer-than-five([list: ])
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
    raise("Cannot compute average of empty list")
  else:
    my-sum(l) / my-len(l)
  end
end

check:
  my-average([list: 2, 4, 6, 8]) is 5
  my-average([list:    4, 6, 8]) is 6
  my-average([list:       6, 8]) is 7
  my-average([list:          8]) is 8
  my-average([list: ]) raises "Cannot compute average of empty list"
end










#Accumulators: maximum using an accumulator
#defining a helper  that carries the current maximum as an accumulator.

#Helper function
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




