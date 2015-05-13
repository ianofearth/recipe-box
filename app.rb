require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  erb(:index)
end

get('/recipes') do
  @recipes = Recipe.all()
  erb(:recipes)
end

get('/recipes/:id') do
  id = params.fetch('id').to_i()
  @recipe = Recipe.find(id)
  erb(:recipe)
end

get('/categories') do
  @categories = Category.all()
  erb(:categories)
end

get("/categories/:id") do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  @recipes = Recipe.all()
  erb(:category)
end

get("/ingredients") do
  @ingredients = Ingredient.all()
  erb(:ingredients)
end

get('/ingredients/:id') do
  id = params.fetch('id')
  @ingredient = Ingredient.find(id)
  @recipes = Recipe.all()
  erb(:ingredient)
end

post('/recipes/new') do
  recipe_name = params.fetch('name')
  instructions = params.fetch('instructions')
  rating = params.fetch('rating').to_i()
  # new_recipe = Recipe.new({:name => recipe_name, :instructions => instructions, :rating => rating})
  # new_recipe.save() # the create will save automatically
  new_recipe = Recipe.create({:name => recipe_name, :instructions => instructions, :rating => rating})
  redirect("/recipes")
end

post('/categories/new') do
  name = params.fetch('name')
  new_category = Category.create({:name => name})
  redirect('/categories')
end

post('/ingredients/new') do
  name = params.fetch('name')
  amount = params.fetch('amount')
  unit_measure = params.fetch('unit_measure')
  new_ingredient = Ingredient.create({:name => name, :amount => amount, :unit_measure => unit_measure})
  redirect("/ingredients")
end

patch('/categories/:id/add_recipe') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  recipe_id = params.fetch('recipe_select').to_i()
  recipe = Recipe.find(recipe_id)
  @category.recipes().push(recipe)
  redirect('/categories/' + id.to_s())
end

patch('/ingredients/:id/add_recipe') do
  id = params.fetch('id').to_i()
  @ingredient = Ingredient.find(id)
  recipe_id = params.fetch('recipe_select').to_i()
  recipe = Recipe.find(recipe_id)
  @ingredient.recipes().push(recipe)
  redirect('/ingredients/' + id.to_s())
end
