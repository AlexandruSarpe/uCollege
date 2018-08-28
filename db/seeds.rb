# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

sec = Secretary.create first_name: 'secretary', last_name: 'user',
                       username: 'secretary', email: 'test_sec@email.com', password: 'testing'

stud = Student.create first_name: 'student', last_name: 'user',
                      username: 'student', email: 'test_stud@email.com', password: 'testing'

Canteen.create first_name: 'canteen', last_name: 'user',
               username: 'canteen', email: 'test_cant@email.com', password: 'testing'

Token.create access_token: ENV['Drive_at'], refresh_token: ENV['Drive_rt'],
             expires_at: ENV['Drive_exp']

unofficialev = UnofficialEvent.create creator_id: stud.id, name: 'unofficial event', place: 'location1',
                                      notes: 'notes', date: Time.now

officialev = OfficialEvent.create creator_id: sec.id, name: 'official event', place: 'location2',
                                  notes: 'notes', date: Time.now
