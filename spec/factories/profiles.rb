FactoryBot.define do
  factory :profile do
    user
    name { FFaker::Name.name }
    kind :regular
  end
end
