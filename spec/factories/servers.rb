FactoryBot.define do
  sequence :name do |n|
    "name#{n}"
  end

  factory :server do
    name
    ip { '127.123.123.1' }
  end
end
