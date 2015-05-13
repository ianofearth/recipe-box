class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :categorys
  has_and_belongs_to_many :ingredients

  validates(:name, {:presence => true, :length => { :minimum => 1 }})
  validates(:instructions, {:presence => true, :length => { :minimum => 1 }})
end
