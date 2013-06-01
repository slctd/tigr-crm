Type.destroy_all
Stage.destroy_all
Currency.destroy_all
Deal.destroy_all
Task.destroy_all

ActionType.create!(name: 'create')
ActionType.create!(name: 'update')
ActionType.create!(name: 'destroy')

User.where(email: 'admin@example.com').destroy_all

admin = User.create!(
  name: 'Administrator',
  email: 'admin@example.com',
  password: 'qwerty',
  password_confirmation: 'qwerty'
)
admin.toggle!(:admin)

User.current = admin

types = I18n.t 'types'

types.each do |type|
  type_class = "#{type[0]}_type".classify.constantize
  type_values = type[1].stringify_keys.keys
  type_values.each {|value| type_class.create name: value}
end

stages = I18n.t('stages').stringify_keys.keys

stages.each do |name|
  success_probability = name.scan(/\d+/).first
  Stage.create name: name, success_probability: success_probability
end

Currency.create name: 'Рубль', abbreviation: 'RUR'
Currency.create name: 'Доллар США', abbreviation: 'USD'

stage = Stage.first
currency = Currency.first

CSV.foreach('db/seeds/deals.csv', headers: true) do |row|
  client_name = row['client']
  company = Company.where(name: client_name).first_or_create! if client_name.present?
  manager = User.where(name: row['manager']).first_or_create do |user|
    user.email = "#{row['manager'].parameterize}@tigr.crm"
    user.password = 'secret'
    user.password_confirmation = 'secret'
  end

  description = <<-DESCRIPTION
<p>Статус: #{row['status']}</p>
<p>Описание: #{row['description']}</p>
  DESCRIPTION
  contact = company.present? ? "#{company.id}_Company" : nil
  Deal.create! name: "##{row['number']} #{row['deal']}", budget: row['sum'].to_f, description: description,
               closing_date: (Date.today + 7.days), contact: contact, currency_id: currency.id,
               stage_id: stage.id, user_id: manager.id
end

task_type_id = TaskType.where(name: 'demo').first.id

CSV.foreach('db/seeds/tasks.csv', headers: true) do |row|

  description = <<-DESCRIPTION
<p>Назначил: #{row['manager']}</p>
<p>Добавлено: #{row['created_at']}</p>
<p>Приоритет: #{row['priority']}</p>
<p>Статус: #{row['status']}</p>
<p>Время: #{row['work_time']}</p>
<p>Задание выполнено: #{row['finished']}</p>
<p>Дата выполнения: #{row['finished_at']}</p>
<p>Результат: #{row['result']}</p>
<p>Принято: #{row['accepted']}</p>
<p>Комментарий: #{row['accepted_comment']}</p>
  DESCRIPTION

  company = Company.where(name: row['company']).first_or_create! if row['company'].present?
  contact = company.present? ? "#{company.id}_Company" : nil

  performer = User.where(name: row['performer']).first_or_create do |user|
    user.email = "#{row['performer'].parameterize}@tigr.crm"
    user.password = 'secret'
    user.password_confirmation = 'secret'
  end

  Task.create(
      name: row['name'],
      description: description,
      deadline_date: row['deadline'].to_date,
      task_type_id: task_type_id,
      user_id: performer.id,
      contact: contact
  )
end
