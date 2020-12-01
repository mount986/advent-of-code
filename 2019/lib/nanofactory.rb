class Nanofactory
  attr_reader :reactions
  attr_reader :storage
  attr_reader :total_ore
  attr_reader :one_fuel_storage

  def initialize(reaction_list)
    @reactions = Array.new

    @storage = {'ORE' => 0}
    @total_ore = 0

    reaction_list.each do |reaction|
      @reactions.push Reaction.new(reaction)
      @storage[@reactions.last.output.element] = 0
    end
  end

  def ore_cost(element: 'FUEL', needed_quantity: 1)
    gather_ingredients(element: 'FUEL', needed_quantity: 1)

    @storage['ORE']
  end

  def gather_ingredients(element: 'FUEL', needed_quantity: 1)
    if element == 'ORE'
      @storage['ORE'] += needed_quantity
      @total_ore += needed_quantity
      @ore_needed = true

      return
    end

    reaction = @reactions.find { |reaction| reaction.output.element == element }

    while needed_quantity > @storage[element]
      reaction.inputs.each do |input|
        if @storage[input.element] < input.quantity
          gather_ingredients(element: input.element, needed_quantity: input.quantity)
        end
        @storage[input.element] -= input.quantity

      end

      @storage[element] += reaction.output.quantity
    end
  end

  def max_fuel(n)
    (1..n).bsearch { |i| ore_cost(element: 'FUEL', needed_quantity: i) > n } - 1
  end

  def increase_by(times)
    @one_fuel_storage.each {|element, quantity| @storage[element] += quantity * times}
    @ore_needed = false
  end

  def store_one_fuel_state
    @one_fuel_storage = @storage.clone
  end

  def ore_needed?
    result = @ore_needed

    @ore_needed = false

    result
  end
end

class Reaction
  attr_reader :inputs
  attr_reader :output

  def initialize(reaction)
    inputs, output = reaction.split(' => ')

    @inputs = inputs.split(', ').map { |input| Ingredient.parse_ingredient(input) }

    @output = Ingredient.parse_ingredient(output)
  end
end

class Ingredient
  attr_reader :element, :quantity

  def initialize(element: nil, quantity: 0)
    @element = element
    @quantity = quantity.to_i
  end

  def self.parse_ingredient(ingredient)
    quantity, element = ingredient.split(' ')
    Ingredient.new(element: element, quantity: quantity)
  end
end