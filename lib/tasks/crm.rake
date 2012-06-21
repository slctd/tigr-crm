# encoding: utf-8
namespace :db do
  desc "Fill database with necessary data"
  task :crm => :environment do
    Rake::Task['db:reset'].invoke
    create_users
    create_contact_types
  end
end

def create_users
  User.create!(email: "admin@example.com", password: "qwerty")  
end

def create_contact_types
  EmailType.create!(name: "Дом")
  EmailType.create!(name: "Работа")
  EmailType.create!(name: "Другой")
  
  PhoneType.create!(name: "Дом")
  PhoneType.create!(name: "Работа")
  PhoneType.create!(name: "Мобильный")  
  PhoneType.create!(name: "Факс")  
  PhoneType.create!(name: "Прямой")  
  PhoneType.create!(name: "Другой")
  
  AddressType.create!(name: "Домашний")
  AddressType.create!(name: "Доставки")
  AddressType.create!(name: "Офис")
  AddressType.create!(name: "Счета")
  AddressType.create!(name: "Другой")
  AddressType.create!(name: "Работа")
end