FactoryGirl.define do

  factory :user do
    sequence :email do |n| "test1#{n}@example.com"
    end
    password "secret"
  end
end