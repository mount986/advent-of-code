require 'factory_bot'

class Fighter
  attr_accessor :id
  attr_accessor :health
  attr_accessor :attack
  attr_accessor :type
  attr_accessor :location
end

FactoryBot.define do
  factory :fighter, class: Fighter do
    sequence(:id) {|id| id}
    attack {3}
    health {200}

    factory :elf, class: Fighter do
      type {:elf}
    end

    factory :ogre, class: Fighter do
      type {:ogre}
    end
  end
end