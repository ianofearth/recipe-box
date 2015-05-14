require('spec_helper')

describe(Recipe) do
    it { should have_and_belong_to_many(:ingredients) }
    it { should have_and_belong_to_many(:categories) }

  describe('.sort_by') do
    it('sorts the array of recipes, by recipe rating we hope') do
      test_1 = Recipe.create({:name => 'test1', :rating =>1, :instructions => "cook" })
      test_2 = Recipe.create({:name => 'test2', :rating =>3, :instructions => "cook" })
      test_3 = Recipe.create({:name => 'test3', :rating =>2, :instructions => "cook" })
      sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
      expect(sorted_recipes).to(eq([test_1, test_3, test_2]))
    end

    it('sorts the array of recipes, by recipe rating in REVERSE') do
      test_1 = Recipe.create({:name => 'test1', :rating =>1, :instructions => "cook" })
      test_2 = Recipe.create({:name => 'test2', :rating =>3, :instructions => "cook" })
      test_3 = Recipe.create({:name => 'test3', :rating =>2, :instructions => "cook" })
      sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
      expect(sorted_recipes.reverse()).to(eq([test_2, test_3, test_1]))
    end

    # it('will sort only rated recipes') do
    #   test_1 = Recipe.create({:name => 'test1', :rating =>1, :instructions => "cook" })
    #   test_2 = Recipe.create({:name => 'test2', :rating =>3, :instructions => "cook" })
    #   test_3 = Recipe.create({:name => 'test3', :rating =>2, :instructions => "cook" })
    #   test_4 = Recipe.create({:name => 'test4', :rating =>0, :instructions => "cook" })
    #   test_5 = Recipe.create({:name => 'test5', :rating =>0, :instructions => "cook" })
    #
    #   sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
    #   expect(sorted_recipes.reverse()).to(eq([test_2, test_3, test_1]))
    # end
  end

  describe('validation') do

    it('validates the presence of a recipe name') do
      recipe = Recipe.new({:name => ""})
      expect(recipe.save()).to(eq(false))
    end
    it('validates the presence of a recipe instructions') do
      recipe = Recipe.new({:instructions => ""})
      expect(recipe.save()).to(eq(false))
    end

    it('allows a user to rate only on a scale of unrated to 10') do
      recipe = Recipe.new({:rating => 11})
      expect(recipe.save()).to(eq(false))
    end
  end

  describe("#title_case") do
    it('will title case recipe names, excluding special words') do
      recipe = Recipe.new(:name => "fancy rice", :instructions => "add water, boil, add ketchup", :rating => 5)
      recipe.save()
      expect(recipe.name()).to(eq("Fancy Rice"))
    end

  end
end
