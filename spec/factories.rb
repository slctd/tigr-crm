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
    task_type_id TaskType.first_or_create(name: "Type").id
    deadline_date 2.days.since
    responsible_id :user
    description { generate(:random_string) }
    
    factory :task_by_company do
      taskable_id :company
      taskable_type "Company"
    end
    
    factory :task_by_person do
      taskable_id :person
      taskable_type "Person"
    end    
  end
  
  factory :deal do
    name { generate(:random_string) }
    description { generate(:random_string) }
    currency_id Currency.first_or_create(name: "Dollar", abbreviation: "USD")
    budget 100
    budget_type BudgetType.first_or_create(name: "fixed")
    closing_date 1.month.since
    responsible_id :user
    stage Stage.first_or_create(name: "Stage")
    success_probability 50
    
    factory :deal_by_company do
      dealable_id :company
      dealable_type "Company"
    end
    
    factory :deal_by_person do
      dealable_id :person
      dealable_type "Person"
    end
  end
  
  factory :stage do
    name { generate(:random_string) }
    success_probability 50
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