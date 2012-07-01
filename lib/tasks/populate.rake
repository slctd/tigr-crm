# encoding: utf-8
namespace :db do
  desc "Fill database with random data"
  task :populate => :environment do
    #Rake::Task['db:reset'].invoke
    create_companies
    create_tasks
    create_deals
    create_events
    create_histories
  end
end

def create_companies
  5.times do
    company = Company.create!(name: Faker::Company.name)
    rand(10).times do
      person = company.people.create!( 
                  firstname: Faker::Name.first_name,
                  lastname: Faker::Name.last_name
                )
      rand(4).times do
        person.emails.create!(
          email: Faker::Internet.email, 
          email_type_id: rand(EmailType.first.id..EmailType.last.id)
        )
      end
    end
  end
end

def create_tasks
  Company.all.each do |company|
    rand(5).times do
      Task.create(
        name: Faker::Lorem.sentence(rand(1..4)),
        description: Faker::Lorem.paragraph,
        deadline_date: rand(2..10).days.since,
        task_type_id: rand(TaskType.first.id..TaskType.last.id),
        responsible_id: User.first.id,
        contact: "#{company.id}_Company"
      )
    end
  end
  
  Person.all.each do |person|
    rand(5).times do
      Task.create!(
        name: Faker::Lorem.sentence(rand(1..4)),
        description: Faker::Lorem.paragraph,
        deadline_date: rand(2..10).days.since,
        task_type_id: rand(TaskType.first.id..TaskType.last.id),
        responsible_id: User.first.id,
        contact: "#{person.id}_Person"
        )
    end
  end
  
  rand(30).times do |n|
    Task.create!(
      name: Faker::Lorem.sentence(rand(1..4)),
      description: Faker::Lorem.paragraph,
      deadline_date: n.days.ago,
      task_type_id: rand(TaskType.first.id..TaskType.last.id),
      responsible_id: User.first.id
    )
  end
end

def create_deals
  Company.all.each do |company|
    rand(5).times do
      Deal.create!(
        name: Faker::Lorem.sentence(rand(1..4)),
        description: Faker::Lorem.paragraph,
        currency_id: rand(Currency.first.id..Currency.last.id),
        budget: rand(100000),
        budget_type_id: rand(BudgetType.first.id..BudgetType.last.id),
        closing_date: rand(2..10).days.since,
        stage_id: rand(Stage.first.id..Stage.last.id),
        contact: "#{company.id}_Company",
        responsible_id: User.first.id
        )
    end
  end
  
  Person.all.each do |person|
    rand(5).times do
      Deal.create!(
        name: Faker::Lorem.sentence(rand(1..4)),
        description: Faker::Lorem.paragraph,
        currency_id: rand(Currency.first.id..Currency.last.id),
        budget: rand(100000),
        budget_type_id: rand(BudgetType.first.id..BudgetType.last.id),
        closing_date: rand(2..10).days.since,
        stage_id: rand(Stage.first.id..Stage.last.id),
        contact: "#{person.id}_Person",
        responsible_id: User.first.id
        )
    end
  end
  
  Deal.all.each do |deal|
    rand(Person.count).times do |n|
      deal.people << Person.find(n+1)
    end
    
    rand(Company.count).times do |n|
      deal.companies << Company.find(n+1)
    end    
  end
end

def create_events
  Company.all.each do |company|
    rand(5).times do
      Event.create!(
        name: Faker::Lorem.sentence(rand(1..4))
      )
    end
  end
  
  Person.all.each do |person|
    rand(5).times do
      Event.create!(
        name: Faker::Lorem.sentence(rand(1..4))
      )
    end
  end
  
  Event.all.each do |event|
    rand(Person.count).times do |n|
      event.people << Person.find(n+1)
    end
    
    rand(Company.count).times do |n|
      event.companies << Company.find(n+1)
    end    
  end
end

def create_histories
  Company.all.each do |company|
    3.times do
      User.first.histories.create!(
        description: Faker::Lorem.paragraph(rand(1..4)),
        history_type_id: rand(HistoryType.first.id..HistoryType.last.id),
        date: Time.now.to_date,
        contact: "#{company.id}_Company"
      )
    end
  end
  
  Person.all.each do |person|
    3.times do
      User.first.histories.create!(
        description: Faker::Lorem.paragraph(rand(1..4)),
        history_type_id: rand(HistoryType.first.id..HistoryType.last.id),
        date: Time.now.to_date,
        contact: "#{person.id}_Person"
      )
    end
  end
  
  Deal.all.each do |deal|
    3.times do
      User.first.histories.create!(
        description: Faker::Lorem.paragraph(rand(1..4)),
        history_type_id: rand(HistoryType.first.id..HistoryType.last.id),
        date: Time.now.to_date,
        deal_id: deal.id
      )
    end
  end
  
  Event.all.each do |event|
    3.times do
      User.first.histories.create!(
        description: Faker::Lorem.paragraph(rand(1..4)),
        history_type_id: rand(HistoryType.first.id..HistoryType.last.id),
        date: Time.now.to_date,
        event_id: event.id
      )
    end
  end
end