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
  
  BudgetType.create!(name: "фиксированный")
  BudgetType.create!(name: "в час")
  BudgetType.create!(name: "в день")
  BudgetType.create!(name: "в неделю")
  BudgetType.create!(name: "в месяц")
  BudgetType.create!(name: "в год")
  
  ContactType.create!(name: "Холодный")
  ContactType.create!(name: "Теплый")  
  ContactType.create!(name: "Горячий")  
  
  HistoryType.create!(name: "Заметка")
  HistoryType.create!(name: "Электронная почта")
  HistoryType.create!(name: "Звонок")
  HistoryType.create!(name: "Встреча")
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

def create_currencies
  Currency.create!(name: "Рубль", abbreviation: "RUR")
  Currency.create!(name: "Доллар США", abbreviation: "USD")
end