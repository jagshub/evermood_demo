FactoryBot.define do
  factory :order, class: Order do
    state { 1 }
    promotion_codes { "PROMO" }
    discount_code   { "DISCO" }

    trait :with_items do
      after(:build) do |order|
        order.items << FactoryBot.build_list(:item, 1)
      end
    end
  end

  factory :pizza, class: Pizza do
    name {"Tonno"}
    size {"Large"}
  end

  factory :item, class: Item do
    order
    pizza
  end
end