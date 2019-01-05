@students = [] #global array for student data

def interactive_menu
  loop do
    print_menu
    menu_actions(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "0. Exit"
end

def menu_actions(selection)
  case selection
  when "1"
    @students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    puts "Which file would you like "
    load_students_from_file
  when "0"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def show_students
  puts
  print_header
  prints_students_list(@students)
  print_footer(@students)
end

def input_students
  current_cohorts = [
    "January", "February", "March", "April",
    "May", "June", "July", "August",
    "September", "October", "November", "December"
  ]
  puts "Please enter the names of the students:"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chop.upcase
  while !name.empty? do
    puts "Please enter the student's cohort:"
    while true do
      cohort = STDIN.gets.chop
    break if current_cohorts.include?(cohort)
      puts "That is not a current cohort, please try again."
    end
    puts "Please enter the student's age:"
    age = STDIN.gets.chop
    puts "Please enter the student's country of birth:"
    country = STDIN.gets.chop.capitalize
    input_student_array(name, cohort, age, country)
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else @students.count > 1
      puts "Now we have #{@students.count} students"
    end
    name = STDIN.gets.chop.upcase
  end
  @students
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

def prints_by_cohort(students)
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
    puts "Overall, we have #{students.count} great student.".center(80)
  else students.count > 1
    puts "Overall, we have #{students.count} great students.".center(80)
  end
end

def input_student_array(name, cohort, age, country)
  @students << {name: name, cohort: cohort.to_sym, age: age, country: country}
end

def save_students
  puts "What would you like to name your file?"
  filename = STDIN.gets.chop
  filename = "students.csv" if filename.nil?
  File.open("#{filename}", "w") do |file|
    @students.each do |student|
    student_data = [student[:name], student[:cohort], [student[:age]], [student[:country]]].join(",")
    file.puts student_data
   end
  end
  puts "Student List saved to #{filename}"
end

def load_csv_on_startup
  filename = ARGV.first #first argument from the command line
  filename = "students.csv" if filename.nil?
  if File.exists?(filename)
    load_students_from_file(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename}.csv does not exist."
    exit
  end
end

def load_students_from_file(filename = "students.csv")
  file = File.open("#{filename}", "r")
  file.readlines.each do |line|
    name, cohort, age, country = line.chomp.split(',')
    input_student_array(name, cohort, age, country)
  end
  file.close
  puts "The #{filename} file has been loaded successfully."
  puts "To view, select option 2."
end

load_csv_on_startup
interactive_menu
