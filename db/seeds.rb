# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Type.destroy_all
Stage.destroy_all
Currency.destroy_all

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