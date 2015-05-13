require('spec_helper')

describe('Recipe') do

  describe('.sort_by') do
    it('sorts the array of recipes, by recipe rating we hope') do
      test_1 = Recipe.create({:name => 'test1', :rating =>1 })
      test_2 = Recipe.create({:name => 'test2', :rating =>3 })
      test_3 = Recipe.create({:name => 'test3', :rating =>2 })
      sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
      expect(sorted_recipes).to(eq([test_1, test_3, test_2]))
    end

    it('sorts the array of recipes, by recipe rating in REVERSE') do
      test_1 = Recipe.create({:name => 'test1', :rating =>1 })
      test_2 = Recipe.create({:name => 'test2', :rating =>3 })
      test_3 = Recipe.create({:name => 'test3', :rating =>2 })
      sorted_recipes = Recipe.all().sort_by{ |recipe| recipe.rating() }
      expect(sorted_recipes.reverse()).to(eq([test_2, test_3, test_1]))
    end
  end
end
