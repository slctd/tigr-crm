# encoding: utf-8
namespace :db do
  desc "Fill database with necessary data"
  task :crm => :environment do
    Rake::Task['db:reset'].invoke
    create_admin
    create_contact_types
    create_stages
    create_currencies
  end
end

def create_admin
  admin = User.create!(
    email: "admin@example.com",
    password: "qwerty",
    password_confirmation: "qwerty"
  )
  admin.toggle!(:admin)
end

def create_contact_types
  EmailType.create!(name: "home")
  EmailType.create!(name: "work")
  EmailType.create!(name: "other")
  
  PhoneType.create!(name: "home")
  PhoneType.create!(name: "work")
  PhoneType.create!(name: "mobile")  
  PhoneType.create!(name: "fax")  
  PhoneType.create!(name: "direct")  
  PhoneType.create!(name: "other")
  
  AddressType.create!(name: "home")
  AddressType.create!(name: "delivery")
  AddressType.create!(name: "office")
  AddressType.create!(name: "account")
  AddressType.create!(name: "other")
  AddressType.create!(name: "work")
  
  TaskType.create!(name: "call")
  TaskType.create!(name: "deal")
  TaskType.create!(name: "demo")
  TaskType.create!(name: "email")
  TaskType.create!(name: "fax")
  TaskType.create!(name: "test")
  TaskType.create!(name: "dinner")
  TaskType.create!(name: "meeting")
  TaskType.create!(name: "note")
  TaskType.create!(name: "delivery")
  TaskType.create!(name: "social")
  TaskType.create!(name: "thanks")
  
  BudgetType.create!(name: "fixed")
  BudgetType.create!(name: "hour")
  BudgetType.create!(name: "day")
  BudgetType.create!(name: "week")
  BudgetType.create!(name: "month")
  BudgetType.create!(name: "year")
  
  ContactType.create!(name: "cold")
  ContactType.create!(name: "warm")
  ContactType.create!(name: "hot")
  
  HistoryType.create!(name: "note")
  HistoryType.create!(name: "email")
  HistoryType.create!(name: "call")
  HistoryType.create!(name: "meeting")
  
  ActionType.create!(name: "create")
  ActionType.create!(name: "update")
  ActionType.create!(name: "destroy")
  
  UserContactType.create!(name: "email")
  UserContactType.create!(name: "phone")
  UserContactType.create!(name: "mobile")
  UserContactType.create!(name: "facebook")
  UserContactType.create!(name: "livejournal")
end

def create_stages
  Stage.create!(name: "stage0", success_probability: 0)
  Stage.create!(name: "stage3", success_probability: 3)
  Stage.create!(name: "stage20", success_probability: 20)  
  Stage.create!(name: "stage50", success_probability: 50)  
  Stage.create!(name: "stage75", success_probability: 75)
  Stage.create!(name: "stage90", success_probability: 90)  
  Stage.create!(name: "stage100", success_probability: 100)
end

def create_currencies
  Currency.create!(name: "Рубль", abbreviation: "RUR")
  Currency.create!(name: "Доллар США", abbreviation: "USD")
end