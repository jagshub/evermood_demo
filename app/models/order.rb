# == Schema Information
#
# Table name: orders
#
#  id              :uuid
#  state           :integer
#  promotion_codes :string
#  discount_code   :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Order < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :pizzas, through: :items,  dependent: :destroy

  enum state: { open: 0, completed: 1 }

  validates_presence_of :items
end
