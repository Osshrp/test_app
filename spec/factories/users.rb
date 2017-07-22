FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password '123456'
    password_confirmation '123456'
    name 'Bill'
    birth_date 30.years.ago
    bio 'Test Bio'
  end
end
