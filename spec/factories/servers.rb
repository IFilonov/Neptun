FactoryBot.define do
  sequence :host_name do |n|
    "host_name#{n}"
  end

  factory :server do
    host_name
    ip { '127.123.123.1' }
  end
end
