FactoryBot.define do
  factory :merchant do
    name {Faker::JapaneseMedia::OnePiece.character}
      after(:create) do |merchant|
        create_list :item, 3, merchant: merchant
      end
  end
end
