use context starter2024

#CLASS EXERCISES
#Exercise 1
# Defining the River type
data River:
  | stream(flow-rate :: Number)
  | merge(width :: Number, left :: River, right :: River)
end

# Sample river network
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)

merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

# Exercise 
fun count-streams(r :: River) -> Number:
  cases (River) r:
    | stream(flow) => 1
    | merge(width, left, right) =>
        count-streams(left) + count-streams(right)
  end
where:
  count-streams(stream-a) is 1
  count-streams(main-river) is 3
end









#EXERCISE 2
#Designing max-width
fun max-width(r :: River) -> Number:
  cases (River) r:
    | stream(flow) => 0
    | merge(width, left, right) =>
        left-max = max-width(left)
        right-max = max-width(right)
      if (width >= left-max) and (width >= right-max):
          width
        else if left-max >= right-max:
          left-max
        else:
          right-max
        end
  end

where:
  max-width(stream(5)) is 0
  max-width(merge(10, stream(5), stream(3))) is 10
  max-width(merge(12, stream(5), merge(15, stream(3), stream(8)))) is 15
end









#EXERCISE 3
fun widen-river(r :: River, amount :: Number) -> River:
  cases (River) r:
    | stream(flow) => stream(flow)
    | merge(width, left, right) =>
        merge(width + amount, widen-river(left, amount), widen-river(right, amount))
  end
end
check:
  widen-river(stream-a, 5) is stream(5)
  widen-river(main-river, 2) is merge(17, merge(14, stream(5), stream(3)), stream(8))
end









#EXERCISE 4
fun cap-flow(r :: River, cap :: Number) -> River:
  cases (River) r:
    | stream(flow) =>
        if flow > cap:
          stream(cap)
        else:
          stream(flow)
        end
    | merge(width, left, right) =>
        merge(width, cap-flow(left, cap), cap-flow(right, cap))
  end
where:
  cap-flow(stream-c, 6) is stream(6)
  cap-flow(main-river, 6) is merge(15, merge(12, stream(5), stream(3)), stream(6))
end









#EXERICE 5
fun has-large-stream(r :: River) -> Boolean:
  cases (River) r:
    | stream(flow) => flow > 5
    | merge(width, left, right) =>
        has-large-stream(left) or has-large-stream(right)
  end
where:
  has-large-stream(stream-b) is false
  has-large-stream(main-river) is true
end













 

