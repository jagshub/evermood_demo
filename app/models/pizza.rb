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
end
