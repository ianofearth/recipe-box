require('spec_helper')

describe('Recipe') do

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

    it('validates the presence of a recipe name') do
      recipe = Recipe.new({:name => ""})
      expect(recipe.save()).to(eq(false))
    end
    it('validates the presence of a recipe instructions') do
      recipe = Recipe.new({:instructions => ""})
      expect(recipe.save()).to(eq(false))
    end
    # it('validates the presence of a recipe rating') do
    #   recipe = Recipe.new({:rating => ""})
    #   expect(recipe.save()).to(eq(false))
    # end

  end
end
