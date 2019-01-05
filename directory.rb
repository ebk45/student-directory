@students = [] #global array for student data

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
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
    exit
  else
    puts "I don't know what you meant, try again"
  end
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
        cohort = STDIN.gets.chop
        break if current_cohorts.include?(cohort)
          puts "That is not a current cohort, please try again."
      end
      puts "Please enter the student's age:".center(80)
      age = STDIN.gets.chop
      puts "Please enter the student's country of birth:".center(80)
      country = STDIN.gets.chop.capitalize
      students << {name: name, cohort: cohort.to_sym,
                   age: age, country: country}
      if students.count == 1
        puts "Now we have #{students.count} student".center(80)
      else students.count > 1
        puts "Now we have #{students.count} students".center(80)
      end
      name = STDIN.gets.chop.upcase
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
    puts "Overall, we have #{students.count} great student.".center(80)
  else students.count > 1
    puts "Overall, we have #{students.count} great students.".center(80)
  end
end

def save_students
  puts "What would you like to name your file?"
  filename = STDIN.gets.chop
  # open new file to write in
  file = File.open("#{filename}.csv", "w")
  #iterate over students array
  @students.each do |student|
    student_data = [student[:name], student[:cohort], [student[:age]], [student[:country]]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Student List saved to #{filename}.csv"
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
  puts "Which csv file would you like to open?"
  filename = STDIN.gets.chop.downcase
  return if filename.nil?
  if File.exists?("#{filename}.csv")
    file = File.open("#{filename}.csv", "r")
    file.readlines.each do |line|
      name, cohort, age, country = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, age: age, country: country}
    end
    file.close
  else
    puts "Sorry, #{filename} doesn't exist."
  end
  puts "The #{filename}.csv file has been loaded successfully."
  puts "To view, select option 2."
end

try_load_students
interactive_menu
