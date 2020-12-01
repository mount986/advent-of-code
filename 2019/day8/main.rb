require_relative '../lib/image'

image_stream = File.read('input.dat').strip

image = Image.new(image_stream)

largest_layer = image.largest_layer

puts largest_layer.count('1') * largest_layer.count('2')

image.build_image

image.print
