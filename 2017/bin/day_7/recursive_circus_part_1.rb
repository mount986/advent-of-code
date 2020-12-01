require './lib/advent_of_code'

parent_list = Array.new
child_list = Array.new

File.readlines('bin/day_7/recursive_circus.dat').each do |line|
  if line.include? '->'
    parent_info, child_info = line.split('->')

    parent_list.push parent_info.strip.split(' ').first
    child_list += child_info.strip.split(', ')
  else
    parent_list.push line.strip.split(' ').first
  end
end

print parent_list - child_list