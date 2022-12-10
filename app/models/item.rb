# == Schema Information
#
# Table name: items
#
#  id                :bigint           not null, primary key
#  order_id          :uuid             not null
#  pizza_id          :bigint           not null
#  ingredients_extra :string
#  ingredients_omit  :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Item < ApplicationRecord
  belongs_to :order
  belongs_to :pizza

  def extras_cost
    cost = 0
    self.ingredients_extra.split(",").each do |extra|
      cost += (Rails.configuration.pricing.ingredients[extra.to_sym].to_f * Rails.configuration.pricing.size_multipliers[self.pizza.size.to_sym].to_f)
    end
    cost
  end
end
