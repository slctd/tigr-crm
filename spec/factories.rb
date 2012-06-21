FactoryGirl.define do
  factory :user do
    #name 'User'
    email { generate(:email) }
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :company do
    name "Company"
  end
  
  sequence :email do |n|
    "email#{n}@example.com"
  end
  
  sequence :random_string do |n|
    "random_string_#{n}"
  end
end