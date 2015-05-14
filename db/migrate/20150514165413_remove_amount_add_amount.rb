class RemoveAmountAddAmount < ActiveRecord::Migration
  def change
    remove_column(:ingredients, :amount, :integer)

    add_column(:ingredients, :amount, :string)
  end
end
