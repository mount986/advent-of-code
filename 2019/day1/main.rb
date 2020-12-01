
input = File.new('input.dat').readlines().map{|line| line.to_i }

fuel_sum = 0

input.each {|mass|	fuel_sum += mass / 3 - 2}

puts fuel_sum

fuel_sum = 0

input.each do |mass|

	while mass > 0
		fuel_extra = mass / 3 - 2 
		fuel_sum += fuel_extra if fuel_extra > 0
		mass = fuel_extra
	end

end

puts fuel_sum