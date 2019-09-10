FactoryBot.define do

  sequence :name do |n|
    "service#{n}"
  end

  factory :service do
    name
  end

  factory :group do
    sequence(:name) { |n| "group#{n}" }

    factory :group_with_services do
      transient do
        services_count { 10 }
      end

      after(:create) do |group, evaluator|
        server = create(:server)
        user = create(:user)
        create_list(:service, evaluator.services_count, group: group, server: server, user: user)
      end
    end
  end
end
