# encoding: utf-8
namespace :db do
  desc "Fill database with necessary data"
  task :crm => :environment do
    Rake::Task['db:reset'].invoke
    create_users
    create_contact_types
    create_stages
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
  
  TaskType.create!(name: "Звонок")
  TaskType.create!(name: "Возможная сделка")
  TaskType.create!(name: "Демо")
  TaskType.create!(name: "Электронная почта")
  TaskType.create!(name: "Факс")
  TaskType.create!(name: "Проверка выполнения")
  TaskType.create!(name: "Обед")
  TaskType.create!(name: "Встреча")
  TaskType.create!(name: "Заметка")
  TaskType.create!(name: "Доставка")  
  TaskType.create!(name: "Социальные сети")
  TaskType.create!(name: "Выражение благодарности")
end

def create_stages
  Stage.create!(name: "Нулевая точка", success_probability: 0)
  Stage.create!(name: "Начало", success_probability: 3)
  Stage.create!(name: "Обсуждение", success_probability: 20)  
  Stage.create!(name: "Оценка", success_probability: 50)  
  Stage.create!(name: "Переговоры", success_probability: 75)
  Stage.create!(name: "Устная договоренность", success_probability: 90)  
  Stage.create!(name: "Успех", success_probability: 100)  
end