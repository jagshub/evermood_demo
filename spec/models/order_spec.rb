require 'rails_helper'
require 'spec_helper'

RSpec.describe Order, type: :model  do
  it 'should have many items' do
    order = create :order, :with_items
    subject { order}
    should have_many(:items)
  end

  it { should validate_presence_of(:items) }
end
