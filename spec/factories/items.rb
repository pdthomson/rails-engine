FactoryBot.define do
  factory :item do
    name {Faker::Games::Zelda.items}
    description {Faker::Movies::VForVendetta.quote}
    unit_price {Faker::Number.within(range: 1..100000)}
  end
end
