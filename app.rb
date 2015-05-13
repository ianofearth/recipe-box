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
  erb(:category)
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
