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

  factory :person do
    firstname { generate(:random_string) }
    lastname { generate(:random_string) }    
  end
  
  factory :email do
    email { generate(:email) }
    email_type
  end
  
  factory :email_type do
    name "Some type"
  end
  
  sequence :email do |n|
    "email#{n}@example.com"
  end
  
  sequence :random_string do |n|
    "random_string_#{n}"
  end
end