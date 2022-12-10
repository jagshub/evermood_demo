class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders, id: :uuid  do |t|
      # t.primary_key :id, type: uuid
      # t.uuid :id, index: { unique: true}
      t.integer :state
      t.string :promotion_codes
      t.string :discount_code

      t.timestamps
    end
  end
end
