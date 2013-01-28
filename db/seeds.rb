# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

PollType.create(name: 'single choice')
PollType.create(name: 'multiple choice')

AdminUser.create(password: 'password', password_confirmation: 'password', email: 'admin@example.com')
Creator.create(password: 'password', password_confirmation: 'password', email: 'meier@example.com')
Category.create(name: 'FH Allgemein')
Category.create(name: 'Sonstiges')