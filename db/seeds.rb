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

Student.create first_name: 'student1', last_name: 'user1',
               username: 'student1', email: 'test_stud1@email.com', password: 'testing'

cant = Canteen.create first_name: 'canteen', last_name: 'user',
                      username: 'canteen', email: 'test_cant@email.com', password: 'testing'

menu1 = Menu.create date: '25/07/2018', mealType: 'lunch', firstCourse: 'Carbonara',
                    secondCourse: 'Pollo', sideDish: 'patate', notes: 'vuoto', canteen_id: cant.id

Menu.create date: '25/07/2018', mealType: 'dinner', firstCourse: 'Amatriciana',
            secondCourse: 'Manzo', sideDish: 'faggiolini', notes: 'vuoto', canteen_id: cant.id

Menu.create date: Time.now.to_date.to_s, mealType: 'lunch', firstCourse: 'Pasta fredda',
            secondCourse: 'Arista con olive', sideDish: 'Insalata mista', notes: 'Vuoto', canteen_id: cant.id

Menu.create date: Time.now.to_date.to_s, mealType: 'dinner', firstCourse: 'Pasta con zucchine e gamberetti',
            secondCourse: 'Cordon bleu', sideDish: 'Verdure lesse miste', notes: 'Niente', canteen_id: cant.id

Reservation.create typeReservation: 'student', firstCourseAlternatives: 'pasta al sugo',
                   sideDishAlternatives: 'fettina', notes: 'niente', student_id: stud.id, menu_id: menu1.id
Book.create title: 'Moby Dick', author: 'Herman Melville', description: 'Adventure', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Book.create title: 'War and Peace', author: 'Lev Tolstoj', description: 'Novel', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Book.create title: '1984', author: 'George Orwell', description: 'Novel', owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id ,current_owner_id: Student.where(['email = ?', 'test_stud@email.com']).first.id

Token.create access_token: ENV['Drive_at'], refresh_token: ENV['Drive_rt'],
             expires_at: ENV['Drive_exp']

unofficialev = UnofficialEvent.create creator_id: stud.id, name: 'unofficial event', place: 'location1',
                                      notes: 'notes', date: Time.now

officialev = OfficialEvent.create creator_id: sec.id, name: 'official event', place: 'location2',
                                  notes: 'notes', date: Time.now

Notification.create title: 'no hot water', description: 'no hot  water on the 5th floor',status: 1

Course.create name: "Enrollable course", begin_year: 2018, end_year: 2019, course_type: "Bachelor", material: "1AXuG5rCnT7ntEengJPybkJoL8kNmm19f"

Course.create name: "old course", begin_year: 1974, end_year: 1975, course_type: "Master", material: "19tjINDujBanBPr9CZbYSWIfh0QkVqjVU"

Course.create name: "almost finished course", begin_year: 2017, end_year: 2018, course_type: "Preparatory", material: "1fYIkAMVaazLARz0RlqXcoesZRU0zr5J9"
