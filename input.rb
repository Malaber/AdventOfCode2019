def get_lines(script_path)
  script_number = File.basename(script_path, '.rb')

  File.readlines("./inputs/#{script_number}.txt")
end
