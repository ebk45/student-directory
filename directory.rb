@students = []

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit #this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" #because we're adding more items later
end

def show_students
  print_header
  prints_students_list(@students)
  print_footer(@students)
end

def input_students
  puts "Please enter the names of the students:".center(80)
  puts "To finish, just hit return twice".center(80)
  students = []
  name = STDIN.gets.chop.upcase
  while !name.empty? do
      puts "Please enter the student's cohort:".center(80)
      while true do
        current_cohorts = [
          "January", "February", "March", "April",
          "May", "June", "July", "August",
          "September", "October", "November", "December"
        ]
        cohort = gets.chop
        break if current_cohorts.include?(cohort)
          puts "That is not a current cohort, please try again."
      end
      puts "Please enter the student's age:".center(80)
      age = gets.chomp
      puts "Please enter the student's country of birth:".center(80)
      country = gets.chop.capitalize
      students << {name: name, cohort: cohort.to_sym,
                   age: age, country: country}
      if students.count == 1
        puts "Now we have #{students.count} student".center(80)
      else students.count > 1
        puts "Now we have #{students.count} students".center(80)
      end
      #we ask the user for another name input because name
      #is currently defined outside the loop
      name = gets.chop.upcase
  end
  #this returns the array of student info hashes the user has inputted
  students
end

def print_header
  puts "The students of Villains Academy:".center(80)
  puts "---------------------------------".center(80)
end

def prints_students_list(students)
  count = 0
  while count < students.count
    puts "#{count + 1}. #{students[count][:name]}, #{students[count][:age]} (#{students[count][:cohort]} Cohort) - #{students[count][:country]}".center(80)
    count += 1
    break if students.empty?
  end
end

def print_by_cohort(students)
  cohort_array = []
  students.map { |student| cohort_array << student[:cohort] }
  newcohort_array = cohort_array.uniq
  count = 0
  while count < newcohort_array.length do
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
  if students.count == 1
    puts "There is #{students.count} great student.".center(80)
  else students.count > 1
    puts "There are #{students.count} great students.".center(80)
  end
end

def save_students
  # open new file to write in
  file = File.open("students.csv", "w")
  #iterate over students array
  @students.each do |student|
    student_data = [student[:name], student[:cohort], [student[:age]], [student[:country]]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit # <-- this quits the program
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

try_load_students
interactive_menu
