FactoryBot.define do

  sequence :name do |n|
    "service#{n}"
  end

  factory :service do
    name
  end
end
