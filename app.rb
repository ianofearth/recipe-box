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

get('/errors') do
  erb(:errors)
end

get('/recipes/sorted_by_rating') do
  @recipes = Recipe.all()
  sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
  @sorted_recipes = sorted_recipes.reverse()
  erb(:recipes_sorted_by_rating)
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
  @recipe = Recipe.new({:name => recipe_name, :instructions => instructions, :rating => rating})
  if @recipe.save()
    redirect("/recipes")
  else
    erb(:errors)
  end
end

post('/recipes/new_sorted_by_rating') do
  recipe_name = params.fetch('name')
  instructions = params.fetch('instructions')
  rating = params.fetch('rating').to_i()
  # new_recipe = Recipe.new({:name => recipe_name, :instructions => instructions, :rating => rating})
  # new_recipe.save() # the create will save automatically
  new_recipe = Recipe.create({:name => recipe_name, :instructions => instructions, :rating => rating})
  redirect("/recipes/sorted_by_rating")
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

delete("/recipes/delete") do
  recipe_id = params.fetch("recipe_select").to_i()
  recipe = Recipe.find(recipe_id)
  recipe.delete()
  redirect("/recipes")
end

delete("/ingredients/delete") do
  ingredient_id = params.fetch('ingredient_select').to_i()
  ingredient = Ingredient.find(ingredient_id)
  ingredient.delete()
  redirect("/ingredients")
end

delete("/categories/delete") do
  category_id = params.fetch('category_select').to_i()
  category = Category.find(category_id)
  category.delete()
  redirect("/categories")
end

patch("/recipes/update") do
  recipe_id = params.fetch("recipe_select").to_i()
  @recipe = Recipe.find(recipe_id)
  if params.fetch("name") != ""
    name = params.fetch("name")
    @recipe.update({:name => name}) #updates recipe and saves name
  end
  if params.fetch("instructions") != ""
    instructions = params.fetch("instructions")
    @recipe.update({:instructions => instructions})
  end
  if params.fetch("rating") != ""
    rating = params.fetch("rating").to_i()
    @recipe.update({:rating => rating})
  end
  redirect("/recipes")
end

patch("/ingredients/update") do
  ingredient_id = params.fetch("ingredient_select").to_i()
  @ingredient = Ingredient.find(ingredient_id)
  if params.fetch("name") != ""
    name = params.fetch("name")
    @ingredient.update({:name => name}) #updates recipe and saves name
  end
  if params.fetch("amount") != ""
    amount = params.fetch("amount")
    @ingredient.update({:amount => amount})
  end
  if params.fetch("unit_measure") != ""
    unit_measure = params.fetch("unit_measure")
    @ingredient.update({:unit_measure => unit_measure})
  end
  redirect("/ingredients")
end

patch("/categories/update") do
  category_id = params.fetch("category_select").to_i()
  @category = Category.find(category_id)
  name = params.fetch("name")
  @category.update({:name => name})
  redirect("/categories")
end
