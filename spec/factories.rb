FactoryGirl.define do
  factory :user do
    #name 'User'
    email { generate(:email) }
    password "foobar"
    password_confirmation "foobar"
  end
  
  factory :company do
    name { generate(:random_string) }
  end

  factory :person do
    firstname { generate(:random_string) }
    lastname { generate(:random_string) }    
  end
  
  factory :task do
    name { generate(:random_string) }
    task_type_id TaskType.first_or_create(name: "Type")
    deadline_date 2.days.since
    responsible_id :user
    description { generate(:random_string) }
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