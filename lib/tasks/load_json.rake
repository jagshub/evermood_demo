namespace :db do
  namespace :seed do
    desc "load data from json"
    task :create_pizzas => :environment do
      orders = [
                {
                  "id": "316c6832-e038-4599-bc32-2b0bf1b9f1c1",
                  "state": "OPEN",
                  "createdAt": "2021-04-14T11:16:00Z",
                  "items": [
                    {
                      "name": "Tonno",
                      "size": "Large",
                      "add": [],
                      "remove": []
                    }
                  ],
                  "promotionCodes": [],
                  "discountCode": nil
                },
                {
                  "id": "f40d59d0-48bd-409a-ac7b-54a1b47f6680",
                  "state": "OPEN",
                  "createdAt": "2021-04-14T13:17:25Z",
                  "items": [
                    {
                      "name": "Margherita",
                      "size": "Large",
                      "add": ["Onions", "Cheese", "Olives"],
                      "remove": []
                    },
                    {
                      "name": "Tonno",
                      "size": "Medium",
                      "add": [],
                      "remove": ["Onions", "Olives"]
                    },
                    {
                      "name": "Margherita",
                      "size": "Small",
                      "add": [],
                      "remove": []
                    },
                  ],
                  "promotionCodes": [],
                  "discountCode": nil
                },
                {
                  "id": "9232679d-e3fd-40bd-81f4-7114ea96e420",
                  "state": "OPEN",
                  "createdAt": "2021-04-14T14:08:47Z",
                  "items": [
                    {
                      "name": "Salami",
                      "size": "Medium",
                      "add": ["Onions"],
                      "remove": ["Cheese"]
                    },
                    {
                      "name": "Salami",
                      "size": "Small",
                      "add": [],
                      "remove": []
                    },
                    {
                      "name": "Salami",
                      "size": "Small",
                      "add": [],
                      "remove": []
                    },
                    {
                      "name": "Salami",
                      "size": "Small",
                      "add": [],
                      "remove": []
                    },
                    {
                      "name": "Salami",
                      "size": "Small",
                      "add": ["Olives"],
                      "remove": []
                    }
                  ],
                  "promotionCodes": ["2FOR1"],
                  "discountCode": "SAVE5"
                }
              ]

      Order.destroy_all
      Pizza.destroy_all

      orders.each do |order|
        o = Order.new
        order[:items].each do |item|
          p = Pizza.find_or_create_by(name: item[:name], size: item[:size])
          o.id = order[:id]
          o.state= order[:state]
          o.promotion_codes = order[:promotionCodes].join(",")
          o.discount_code = order[:discountCode]
          order_item = o.items.build
          order_item.pizza_id = p.id
          order_item.ingredients_extra = item[:add]&.join(",")
          order_item.ingredients_omit = item[:remove]&.join(",")
          o.items << order_item
        rescue ActiveRecord::RecordNotUnique => e
        end
        o.save!
      end
    end
  end
end