instructions = File.readlines('input.dat', chomp: true)

def apply_mask_v1(mask, value)
  bit_value = '%036b' % value
  final_value = ''

  36.times do |index|
    final_value << (mask[index] == 'X' ? bit_value[index] : mask[index])
  end

  final_value.to_i(2)
end

def apply_mask_v2(mask, value)
  bit_value = '%036b' % value
  final_value = ''

  36.times do |index|
    final_value << case mask[index]
                   when '0'
                     bit_value[index]
                   when '1'
                     '1'
                   when 'X'
                     'X'
                   end
  end

  final_value
end

def interpolate_mask_v2(memory, mask_template, value, index)
  if index >= mask_template.length
    memory[mask_template.to_i(2)] = value.to_i
    return
  end

  if mask_template[index] == 'X'
    a = mask_template.chars

    a[index] = '0'
    interpolate_mask_v2(memory, a.join(''), value, index + 1)

    a[index] = '1'
    interpolate_mask_v2(memory, a.join(''), value, index + 1)
  else
    interpolate_mask_v2(memory, mask_template, value, index + 1)
  end


end

memory_v1 = Hash.new
memory_v2 = Hash.new
mask = 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'

instructions.each do |instruction|
  action, value = instruction.split(' = ')

  if action == 'mask'
    mask = value
    next
  end

  loc = action.match(/\d+/)[0]
  memory_v1[loc] = apply_mask_v1(mask, value)
  mask_template_v2 = apply_mask_v2(mask, loc)

  interpolate_mask_v2(memory_v2, mask_template_v2, value, 0)
end

puts memory_v1.values.sum
puts memory_v2.values.sum
