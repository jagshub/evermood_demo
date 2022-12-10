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

  enum state: { OPEN: 0, COMPLETED: 1 }

  validates_presence_of :items

  def total_price
    items_total_price = 0.00
    promo_savings = 0.00

    #(Note) Jag: Prevent N+1 queries
    Order.includes(:items => :pizza).where('orders.id = ?', self.id).map do |order|
      promo_savings = apply_promotion(order) if order.promotion_codes.present?
      order.items.each do |item|
        pp get_item_price(item)
        items_total_price += get_item_price(item)
      end
      items_total_price = items_total_price - promo_savings
      items_total_price = apply_discount(order.discount_code, items_total_price)  if order.discount_code.present?
    end
    items_total_price
  end

  private

  def get_item_price(item)
    extra_ingredients_cost =  item.ingredients_extra.present? ? item.extras_cost : 0
    item.pizza.cost + extra_ingredients_cost
  end

  def apply_promotion(order)
    promos = []
    savings = 0
    order.promotion_codes.split(",").each do |promo_code|
      promos << Rails.configuration.pricing.promotions[promo_code.to_sym]
    end
    promos.each do |promo|
      #(Note) Jag: Prevent N+1 queries
      items_eligible = order.items.includes(:pizza).map(&:pizza).filter { |pizza| pizza.name == promo[:target] && pizza.size == promo[:target_size]}
      unless items_eligible.blank?
        savings +=  (items_eligible[0].cost * items_eligible.size) * (promo[:to].to_f / promo[:from].to_f)
      end
    end
    savings
  end

  def apply_discount(discount_code, items_total_price)
    discounted_price = items_total_price - ( items_total_price * Rails.configuration.pricing.discounts[discount_code.to_sym][:deduction_in_percent] / 100 )
    discounted_price
  end
end
