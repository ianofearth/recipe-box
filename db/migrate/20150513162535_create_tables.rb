class CreateTables < ActiveRecord::Migration
  def change
    create_table(:recipes) do |t|
      t.column(:name, :string)
      t.column(:instructions, :string)
      t.column(:rating, :integer)
    end

    create_table(:ingredients) do |t|
      t.column(:name, :string)
      t.column(:amount, :integer)
      t.column(:unit_measure, :string)
    end

    create_table(:categories) do |t|
      t.column(:name, :string)
    end
  end
end
