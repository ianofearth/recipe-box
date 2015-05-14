class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :ingredients

  validates(:name, {:presence => true, :length => { :minimum => 1 }})
  validates(:instructions, {:presence => true, :length => { :minimum => 1 }})
  before_save(:title_case_recipe)

private

  define_method(:title_case_recipe) do
    special_words = ["and", "at", "it", "with", "to", "the", "of", "from", "but", "on", "or", "by"]
    capitalized_recipe = []
    self.name=(recipe = self.name.split(" ")
    recipe.each do |word|
      if special_words.include?(word)
        capitalized_recipe.push(word)
      else
        word.capitalize!()
        capitalized_recipe.push(word)
      end
    end
    capitalized_recipe.join(" "))
  end

end
