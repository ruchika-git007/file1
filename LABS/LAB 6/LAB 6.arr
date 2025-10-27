use context dcic2024
include csv
include data-source
include lists

student_score = load-table:
  Name :: String,
  Surname :: String,
  Email :: String,
  Score :: Number
  source: csv-table-file("students_gate_exam_score.csv", default-options)
  sanitize Score using num-sanitizer
end

student_score

#order-by(t :: Table, colname :: String, sort-up :: Boolean) -> Table
ordered_students = order-by(student_score, "Score", false)
ordered_students

top_student = ordered_students.row-n(0)["Score"]
second_student = ordered_students.row-n(1)["Score"]
third_student = ordered_students.row-n(2)["Score"]
top_student
second_student
third_student

#Defining Student data type
data Student:
  |student(name :: String, surname :: String, score :: Number)
end

#Creating Structured Data for top 3 students
s1 = student("Ethan", "Gray", 97)
s2 = student("Oscar", "Young", 92)
s3 = student("Adrian", "Bennett", 80)

#Recursive Function
#Creating a List
scores :: List<Number> =
  link(s1.score, link(s2.score, link(s3.score, empty)))
scores


#|fun above-90(score :: List) -> Number:
 if score > 90:
    my-len(score)
  else:
    score
  end
   end 

fun my-len(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => link(f, above-90(r))
  end
end
    
my-len(scores)
   fun above-90(n :: Number) -> Number:if n > 90:|#
      
     
 
#Extracting the email column as a list


data Studentmail:
  |studentmail(email :: String)
end



students-emails = student_score.get-column("Email")
Ethan_email = student_score.row-n(0)["Email"]
Oscar_email = student_score.row-n(1)["Email"]
Adrian_email = student_score.row-n(2)["Email"]
Nina_email = student_score.row-n(3)["Email"]
Laura_email = student_score.row-n(4)["Email"]
Gavin_email = student_score.row-n(5)["Email"]
Kyle_email = student_score.row-n(6)["Email"]
Ian_email = student_score.row-n(7)["Email"]
Diana_email = student_score.row-n(8)["Email"]
Marcus_email = student_score.row-n(9)["Email"]

#Creating List
all-emails :: List<Number> =
  link(Ethan_email,link(Oscar_email, link(Adrian_email, link(Nina_email, link(Laura_email, link(Gavin_email, (link(Kyle_email, link(Ian_email, link(Diana_email, link(Marcus_email, empty)))))))))))
all-emails
      
#Extracting Domain Names
#fun get-domain


#Replace Doamin




    