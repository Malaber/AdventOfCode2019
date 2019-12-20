require_relative '../input'
lines = get_lines $PROGRAM_NAME

class RecipeBook
  def initialize
    @recipes = []
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def get_recipe(output)
    valid_recipes = @recipes.select { |r| r.output.type == output }
    case valid_recipes.size
    when 0
      p output
      throw 'No recipe found for that output'
    when 1
      valid_recipes.first
    else
      throw "Multiple Recipe options, don't know which to choose"
    end
  end

  def to_s
    string = "Recipe Book:\n\n"
    @recipes.each do |recipe|
      string += recipe.to_s + "\n"
    end

    string
  end
end

class Recipe
  def initialize(inputs, output)
    @inputs = inputs
    @output = output
  end

  attr_reader :output
  attr_reader :inputs

  def to_s
    string = ''

    @inputs.each do |input|
      string += input.to_s + ', '
    end
    string.gsub!(/, $/, '')
    string += ' => '

    string + @output.to_s
  end
end

class Unit
end

class Resource
  def initialize(type, amount)
    @type = type
    @amount = []
    add_amount(amount)
  end

  attr_reader :type

  def amount
    @amount.size
  end

  def add_amount(amount)
    amount.times do
      @amount << Unit.new
    end
  end

  def remove_amount(amount)
    @amount.pop(amount)
  end

  def to_s
    "#{@amount.size} #{@type}"
  end
end

class ResourceStash
  def initialize
    @stash = []
    @ore_pool = []
  end

  def add_resource_to_stash(resource, amount)
    resource_in_stash = get_resource_from_stash(resource)
    if resource_in_stash.empty?
      @stash << Resource.new(resource, amount)
    else
      resource_in_stash.first.add_amount(amount)
    end
  end

  def get_resource_from_stash(resource)
    @stash.select { |r| r.type == resource }
  end

  def take_resource_from_stash(resource, amount)
    # return amount you still need to produce of that resource

    resource_in_stash = get_resource_from_stash(resource).first
    available_amount = resource_in_stash.nil? ? 0 : resource_in_stash.amount
    difference = available_amount - amount
    if difference.zero?
      @stash.delete(resource_in_stash)
      0
    elsif difference.positive?
      resource_in_stash.remove_amount(amount)
      0
    else
      @stash.delete(resource_in_stash)
      difference * -1
    end
  end

  def produce(resource, amount, recipe_book)
    if resource == "ORE"
      amount.times do
        @ore_pool << Unit.new
      end

      return
    end

    amount_to_produce = take_resource_from_stash(resource, amount)
    if amount_to_produce.zero?
      nil
    else
      recipe = recipe_book.get_recipe(resource)
      recipe.inputs.each do |input|
        produce(input.type, input.amount, recipe_book)
      end
      difference = recipe.output.amount - amount_to_produce
      unless difference.zero?
        difference = difference.abs
        add_resource_to_stash(resource, difference)
      end
    end

    @ore_pool.size
  end
end

recipe_book = RecipeBook.new

lines.each do |line|
  inputs, output = line.split(' => ')
  ingredients = inputs.split(', ')

  inputs = []
  ingredients.each do |ingredient|
    amount, type = ingredient.split(' ')
    inputs << Resource.new(type, amount.to_i)
  end

  output_amount, output_type = output.split(' ')
  output = Resource.new(output_type, output_amount.to_i)
  recipe_book.add_recipe(Recipe.new(inputs, output))
end

resource_stash = ResourceStash.new
p resource_stash.produce("FUEL", 1, recipe_book)
