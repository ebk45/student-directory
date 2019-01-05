File.open(__FILE__, "r") do |file| #opens the parent file (itself)
  file.each { |line| puts line } #reads each line and prints it to the console
end
