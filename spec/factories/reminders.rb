FactoryBot.define do
  factory :reminder do
    user
    label 'Energy'
    due_date '2018-05-13'
    status :pending
    amount '9.99'
    recurrent false
  end
end
