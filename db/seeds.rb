# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: '전지원', email: "jwurbane97@ajou.ac.kr", password: "urbane97#", permission: false)
User.create(name: '임재훈', email: "admin@dimigo.hs.kr", password: "idimigo", permission: true)