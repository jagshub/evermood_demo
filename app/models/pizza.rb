# == Schema Information
#
# Table name: pizzas
#
#  id         :bigint           not null, primary key
#  name       :string
#  size       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Pizza < ApplicationRecord
  has_many :items, dependent: :destroy

  def cost
    (Rails.configuration.pricing.pizzas[self.name.to_sym].to_f * Rails.configuration.pricing.size_multipliers[self.size.to_sym].to_f)
  end
end
