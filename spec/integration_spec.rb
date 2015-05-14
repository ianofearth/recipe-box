require('spec_helper')
require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("adding a new recipe", {:type => :feature}) do
  it("allows a user to add a recipe to the list of recipes") do
    visit("/")
    click_link("View All Recipes")
    fill_in("name", :with => "rice")
    fill_in("instructions", :with => "add water, boil")
    fill_in("rating", :with => 3)
    click_button("Add Recipe")
    expect(page).to have_content("Rice")
  end
end

describe("removing recipes", {:type => :feature}) do
  it("allows a user to select a recipe from a dropdown to delete") do
    recipe = Recipe.create({:name => "rice", :instructions => "add water, boil", :rating => 3})
    recipe2 = Recipe.create({:name => "noodles", :instructions => "add water, boil", :rating => 3})
    visit('/recipes')
    select('Rice', :from => 'recipe_select')
    click_button('Delete recipe')
    expect(page).to have_content("Noodles")
  end
end

describe("add recipe to category", {:type => :feature}) do
  it("allows a user to add a recipe to a category") do
    recipe = Recipe.create({:name => "fancy rice", :instructions => "add water, boil, add ketchup", :rating => 7})
    category = Category.create({:name => "fancy foods"})
    visit('/categories')
    click_link("fancy foods")
    select("Fancy Rice", :from => "recipe_select_category")
    click_button("Add Recipe to Category")
    expect(page).to have_content("Fancy Rice")
  end
end
