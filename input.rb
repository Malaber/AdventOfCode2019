def get_lines(script_path)
  script_number = File.basename(script_path, '.rb')

  puts "##########################"
  puts
  puts "#############{script_number}############"
  puts
  puts "##########################"
  puts

  File.readlines("#{File.dirname(script_path)}/../inputs/#{script_number}.txt")
end
