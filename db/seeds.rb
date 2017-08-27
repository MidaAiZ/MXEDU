# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin1 = Manage::Admin.create number: :Mida, password: '1124520', role: :super
admin2 = Manage::Admin.create number: :xueba, password: 'xueba@mxjyu', role: :super
puts '创建超级管理员1成功, 帐号: Mida, 密码: 1124520' if admin1
puts '创建超级管理员1失败' unless admin1
puts '\n'
puts '创建超级管理员2成功, 帐号: xueba, 密码: xueba@mxjyu' if admin2
puts '创建超级管理员2失败' unless admin2
