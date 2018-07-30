# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Secretary.create first_name: 'secretary', last_name: 'user',
                 username: 'secretary', email: 'test_sec@email.com', password: 'testing'

Student.create first_name: 'student', last_name: 'user',
               username: 'student', email: 'test_stud@email.com', password: 'testing'

Canteen.create first_name: 'canteen', last_name: 'user',
               username: 'canteen', email: 'test_cant@email.com', password: 'testing'

Book.create title: 'Moby Dick', author: 'Herman Melville', description: 'Adventure', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Book.create title: 'War and Peace', author: 'Lev Tolstoj', description: 'Novel', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Book.create title: '1984', author: 'George Orwell', description: 'Novel', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Token.create access_token: ENV['Drive_at'], refresh_token: ENV['Drive_rt'],
             expires_at: ENV['Drive_exp']
