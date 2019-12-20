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
    valid_recipes = @recipes.select { |r| r.output == output }
    case valid_recipes.size
    when 0
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

  def add_amount(amount)
    amount.times do
      @amount << Unit.new
    end
  end

  def to_s
    "#{@amount.size} #{@type}"
  end
end

class ResourceStash
  def initialize
    @stash = []
  end

  def add_resource_to_stash(resource, amount)
    resource_in_stash = get_resource_from_stash(resource)
    if resource_in_stash.nil?
      @stash << Resource.new(resource, amount)
    else
      resource_in_stash.add_amount(amount)
    end
  end

  def get_resource_from_stash(resource)
    @stash.select { |r| r.type == resource }
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

puts recipe_book
