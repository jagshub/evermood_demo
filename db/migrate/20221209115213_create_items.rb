class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items  do |t|
      t.references :order, null: false, type: :uuid,  foreign_key: true
      t.references :pizza, null: false, foreign_key: true
      t.string :ingredients_extra
      t.string :ingredients_omit

      t.timestamps
    end
  end
end
