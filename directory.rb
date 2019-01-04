def input_students
  puts "Please enter the names of the students: "
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp.capitalize
  while !name.empty? do
      puts "Please enter the student's cohort: "
      cohort = gets.chomp.capitalize
      puts "Please enter the student's age: "
      age = gets.chomp
      puts "Please enter the student's country of birth: "
      country = gets.chomp.capitalize
      students << {name: name, cohort: cohort,
                   age: age, country: country}
      puts "Now we have #{students.count} students"
      #we ask the user for another name input because name
      #is currently defined outside the loop
      name = gets.chomp.capitalize
  end
  #this returns the array of student info hashes the user has inputted
  students
end

def print_header
  puts "The students of Villains Academy", "------------"
end

def print(students)
  count = 0
  while count < students.count
    puts "#{count + 1}. #{students[count][:name]}, #{students[count][:age]} (#{students[count][:cohort]} cohort) - #{students[count][:country]}"
    count += 1
  end
end

def print_by_initial(students)
  puts "You can search the directory by a students first initial."
  puts "Please enter an initial: "
  initial_input = gets.chomp
  count = 1
  students.each {|student|
    if student[:name][0] == initial_input.upcase
      puts "#{count + 1}. #{students[count][:name]}, #{students[count][:age]} (#{students[count][:cohort]}) - #{students[count][:country]}"
      count += 1
    end
  }
end

def print_under_12_chars(students)
  count = 1
  students.each {|student|
    if student[:name].length < 12
      puts "#{count + 1}. #{students[count][:name]}, #{students[count][:age]} (#{students[count][:cohort]}) - #{students[count][:country]}"
      count += 1
    end
  }
end

def print_footer(students)
  puts "There are #{students.count} students with names under 12 characters."
  puts "This includes punctuation and spacing."
end

students = input_students
#returns array of students that will be the argument in the following methods
print(students)
