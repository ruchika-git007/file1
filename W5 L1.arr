use context dcic2024
include csv
include tables

# Load the dataset from URL (you can replace with local voters.csv if uploaded)
voter-data =
  load-table: VoterID, DOB, Party, Address, City, County, Postcode
    source: csv-table-file("voters.csv", default-options)
end

voter-data


filter-with(voter-data, lam(r): r["Party"] == "Labour" end).length()

#PROBLEM 1
#Transforms empty cells to "undecided"
fun blank-to-undecided(s :: String) -> String:
  doc: "replaces an empty string with Undecided"
  if s == "":
    "Undecided"
  else:
    s
  end
where:
  blank-to-undecided("") is "Undecided"
  blank-to-undecided("blah") is "blah"
end

undecided-voters = transform-column(voter-data, "Party", blank-to-undecided)
undecided-voters


freq-bar-chart(undecided-voters, "Party")





#The County has a single row that has bad data. Identify what it is. Can this be corrected through an automated process? Or can you correct in manually.
# Removes unwanted spaces from County column

#sO BASICALLY One row in the County column has a formatting issue: extra whitespace.
filter-with(voter-data, lam(r): r["County"] == "West Yorkshire " end)

#MaKING A STRING-TRIM FUNCTION TO REMOVE WHITE SPACE

fun trim-leading-colons(s :: String) -> String:
  if string-starts-with(s, ":"):
    trim-leading-colons(string-substring(s, 1, string-length(s)))
  else:
    s
  end
where:
  trim-leading-colons(":::hello") is "hello"
  trim-leading-colons("hello") is "hello"
end
clean-county = transform-column(voter-data, "County", trim-leading-colons)




#PROBLEM 2
#Design a function called normalize-date that takes the current DD/MM/YYYY format in the DOB column and turns it into ISO format YYYY-MM-DD
#Start by making a plan in comments and following the full design recipe
# Function to normalize date
#In chapter 3.13
#MY EXPLANATION
# This function, normalize-postcode1, reformats postcodes into the standard UK format 'XXXX YYY'. 
# It converts all letters to uppercase, removes any spaces, and then reinserts a space before 
# the last three characters to ensure consistency. The transform-column function then applies 
# this formatting to every postcode in the 'Postcode' column of the voter-data table.
#check why bracket expression is working
#HAVE TO USE STRING AND SUBSTRING, YOU HAVE TO ASSIGN STRING 1 AND 2 AND ASSIGN IT
fun normalize-date(date :: String) -> String:
  year = string-substring("12-05-1980", 6, 10)
  month = string-substring("12-05-1980", 3, 5)
  day = string-substring("12-05-1980", 0, 2)
  year + "-" + month + "-" + day
  end
# Applying to DOB column
normalized-dates = transform-column(voter-data, "DOB", normalize-date)


#string-substring(name-string, "").get(0) #get first name
#using string-substring function
#fun normalize-date(d :: String) -> String:
#  doc: "Convert DD/MM/YYYY to YYYY-MM-DD"
#  date = "DD/MM/YYYY"
# first = string-substring(date, 0, 6)
#end
#first
  #where:
  #normalize-date("25/08/1998") is "1998-08-25"
  #end


#use code below
fun normalize-data(date :: String) -> String:
  year = string-substring("12-05-1980", 6, 10)
  month = string-substring("12-05-1980", 3, 5)
  day = string-substring("12-05-1980", 0, 2)
  year + "-" + month + "-" + day
  end



#PROBLEM 3
# Design a function called normalize-postcode that transforms all the postcodes to use the following format:
#All letters in capitals
#The first part of the postcode can be up to four characters long
#This should be followed by a space
#The last part of the postcode is always three characters long
#Think about a strategy using string-substring (multiple times, with comparisons)
#MY EXPLANATION
# This function, normalize-postcode, ensures that all postcodes follow the standard UK format 'XXXX YYY'. 
# It first converts the postcode to uppercase, removes any existing spaces, and measures its total length. 
# Then, it separates the last three characters (the suffix) from the rest (the prefix) using string-substring, 
# and joins them with a space in between. Finally, transform-column applies this formatting to every postcode 
# in the 'Postcode' column of the voter-data table.

fun normalize-postcode(pc :: String) -> String:
  doc: "Formats postcode to 'XXXX YYY' with uppercase letters"
  upper = string-to-upper(pc)
  no-space = string-replace(upper, " ", "")
  len = string-length(no-space)
  prefix = string-substring(no-space, 0, len - 3)
  suffix = string-substring(no-space, len - 3, len)
  prefix + " " + suffix
where:
  normalize-postcode("sw177pf") is "SW17 7PF"
  normalize-postcode("l14 2de") is "L14 2DE"
end
#Applying the function to my table
normalized-postcodes = transform-column(voter-data, "Postcode", normalize-postcode)



#the second problem is a string substring problem