require_relative 'lib/processor.rb'

def prompt
  print '> '
end

def breakline
  puts "\n"
end

option = 0
while option != 7
  puts """
    Welcome to Gympass race center

    1. Set race results
    2. Process file
    3. Show race results
    4. Show pilot's best LAP
    5. Show race's best LAP
    6. Show pilot's avg speed
    7. Exit
  """
  prompt

  option = gets.chomp.to_i
  breakline

  case option
  when 1
    puts 'Please enter log path'
    prompt
    file_path   = gets.chomp
    @processor = Processor.new(file_path)

    breakline

    puts @processor.race_file.nil? ? 'Sorry, but it was not possible to read race results file. Please try again' : 'Rece results was successfully loaded'

  when 2
    @processor.process

  when 3
    puts @processor.print_race_results

  when 4
    puts @processor.print_best_lap_by_pilot

  when 5
    puts @processor.print_race_best_lap

  when 6
    puts @processor.print_avg_speed
    
  when 7
    puts 'Bye bye user!'

  else
    puts 'Please select a correct option'

  end
end