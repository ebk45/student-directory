def input_students
  puts "Please enter the names of the students:".center(80)
  puts "To finish, just hit return twice".center(80)
  students = []
  name = gets.chomp.upcase
  while !name.empty? do
      puts "Please enter the student's cohort:".center(80)
      while true do
        current_cohorts = [
          "January", "February", "March", "April",
          "May", "June", "July", "August",
          "September", "October", "November", "December"
        ]
        cohort = gets.chomp
        break if current_cohorts.include?(cohort)
          puts "That is not a current cohort, please try again."
      end
      puts "Please enter the student's age:".center(80)
      age = gets.chomp
      puts "Please enter the student's country of birth:".center(80)
      country = gets.chomp.capitalize
      students << {name: name, cohort: cohort.to_sym,
                   age: age, country: country}
      if students.count == 1
        puts "Now we have #{students.count} student".center(80)
      else students.count > 1
        puts "Now we have #{students.count} students".center(80)
      end
      #we ask the user for another name input because name
      #is currently defined outside the loop
      name = gets.chomp.upcase
  end
  #this returns the array of student info hashes the user has inputted
  students
end

def print_header
  puts "The students of Villains Academy:".center(80)
  puts "---------------------------------".center(80)
end

def print(students)
  count = 0
  while count < students.count
    puts "#{count + 1}. #{students[count][:name]}, #{students[count][:age]} (#{students[count][:cohort]} Cohort) - #{students[count][:country]}".center(80)
    count += 1
  end
end

def print_by_cohort(students)
  cohort_array = []
  students.map { |student| cohort_array << student[:cohort] }
  count = 0
  while cohort_array.length > count do
    puts "#{cohort_array[count]} Cohort: ".center(80)
    students.each do |student|
      if student[:cohort] == cohort_array[count]
        puts "#{student[:name]}, #{student[:age]} - #{student[:country]}".center(80)
      end
    end
    count += 1
  end
end

def print_footer(students)
  puts "There are #{students.count} students with names under 12 characters.".center(80)
  puts "This includes punctuation and spacing.".center(80)
end

students = input_students
#returns array of students that will be the argument in the following methods
print_by_cohort(students)
