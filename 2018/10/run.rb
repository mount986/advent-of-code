require './sky'

sky = Sky.new('input.txt')
sky.speed_up(10300)

sky.show_lights
while sky.time_passes
  sky.show_lights
end
