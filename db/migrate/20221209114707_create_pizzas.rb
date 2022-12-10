class CreatePizzas < ActiveRecord::Migration[6.1]
  def change
    create_table :pizzas do |t|
      t.string :name
      t.string :size

      t.timestamps
      t.index [:name, :size], unique: true
    end
  end
end
