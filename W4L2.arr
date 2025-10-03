use context dcic2024
include csv
include data-source

#CLASS EXERCISES
#Imagine all the items were pulled closer to the player by 10%.

#Create a new table that has new x & y coordinates for all the items.


items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end



fun scale-coord(n :: Number) -> Number:
  doc: "reduces a coordinate by 10%"
  n * 0.9
where:
  scale-coord(100) is 90
  scale-coord(-50) is -45
end

scaled-items =
  transform-column(
    transform-column(items, "x-coordinate", scale-coord),
    "y-coordinate", scale-coord
  )




#Extract the name of the item that is closest to the player.
fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-sqrt(
    num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"])
  )
where:
  calc-distance(items.row-n(0)) is-roughly num-sqrt(num-sqr(23) + num-sqr(-87))
  calc-distance(items.row-n(3)) is-roughly num-sqrt(num-sqr(-9) + num-sqr(64))
end




#You want to "obfuscate" the list of items, displaying, rather than the name, a string that is a sequence of "X"s of the same length.

#i.e., "Sword of Dawn" becomes "XXXXXXXXXXXXX".
#Create a new table with the item name obfuscated
#Convert the "obfuscation" into a function that accepts a table and write examples for it. Note: your example tables should only need an "item" column!

#Creating the function
fun obfuscate-name(r :: Row) -> String:
  string-repeat("X", string-length(r["item"]))
end


#Example table with only the "item" column
fun obfuscate-table(t :: Table) -> Table:
  build-column(t, "obfuscated", lam(r): string-repeat("X", string-length(r["item"])) end)
where:
  test-items = table: item
    row: "Sword"
    row: "Potion"
  end

  obfuscate-table(test-items) is
  table: item, obfuscated
    row: "Sword", "XXXXX"
    row: "Potion", "XXXXXX"
  end
end




#Design a function called add-vat that takes a table with a price column and adds a new column called total which adds 20% to the value inside the price column.
#You can assume there is not already a total column.
#Ensure that you follow the design recipe and add examples for your tables inside the function.

fun add-vat(t :: Table) -> Table:
  doc: "adds 20% VAT to 'price' column"
  build-column(t, "total", lam(r): r["price"] * 1.2 end)
where:
  test-table = table: price
    row: 100
    row: 50
  end

  add-vat(test-table) is
    table: price, total
      row: 100, 120
      row: 50, 60
    end
end





#Download and load the file in Pyret inside your GitHub repository
ons_table = load-table:
  Code :: String,
  Indicies :: String,
  Aug-24 :: Number,
  Sep-24 :: Number,
  Oct-24 :: Number,
  Nov-24 :: Number,
  Dec-24 :: Number,
  Jan-25 :: Number,
  Feb-25 :: Number,
  Mar-25 :: Number,
  Apr-25 :: Number,
  May-25 :: Number,
  Jun-25 :: Number,
  Jul-25 :: Number,
  Aug-25 :: Number
  source: csv-table-file("ons-cpih-aug25.csv", default-options)  
    sanitize Aug-24 using num-sanitizer
    sanitize Aug-25 using num-sanitizer
end


#Create a new column difference which calculates the difference between the column for Aug-24 and Aug-25
ons-with-diff = build-column(
  ons_table,
  "difference",
  lam(r): r["Aug-25"] - r["Aug-24"] end
)

#Create another column pct-difference which contains the percentage difference between the difference column and the Aug-24 column
ons-with-pct = build-column(
  ons-with-diff,
  "pct-difference",
  lam(r):
    ((r["Aug-25"] - r["Aug-24"]) / ((r["Aug-25"] + r["Aug-24"]) / 2)) * 100
  end
)

#Order the table according to the pct-difference column
ordered_ons = order-by(ons-with-pct, "pct-difference", false)

ordered_ons







