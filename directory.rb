def input_students
  puts "Please enter the names of the students: "
  puts "To finish, just hit enter/return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end
  #this returns the array of the students the user has inputted
  students
end

def print_header
  puts "The students of Villains Academy", "------------"
end

def print(students)
  count = 0
  while count < students.count
    puts "#{count + 1}. #{students[count][:name]} (#{students[count][:cohort]} cohort)"
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
      puts "#{count}: #{student[:name]} (#{student[:cohort]} cohort)"
      count += 1
    end
  }
end

def print_under_12_chars(students)
  count = 1
  students.each {|student|
    if student[:name].length < 12
      puts "#{count}: #{student[:name]} (#{student[:cohort]} cohort)"
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
