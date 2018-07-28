User.create!([
  {roles_mask: nil, type: "Secretary", first_name: "secretary", last_name: "user", username: "secretary", email: "test_sec@email.com", encrypted_password: "$2a$11$pxtiwkvDEK1J68zcJuqFbuXOCXgg5MU8fPc24atKQHhVuQ7/SCgmq", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil},
  {roles_mask: nil, type: "Student", first_name: "student", last_name: "user", username: "student", email: "test_stud@email.com", encrypted_password: "$2a$11$KEUaJiN/RJMGoTHlfaftSuqeI3TgvnUhbPG9nP1URyEzfmmx8SGXG", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2018-07-28 08:26:10", last_sign_in_at: "2018-07-27 17:44:00", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"},
  {roles_mask: nil, type: "Canteen", first_name: "canteen", last_name: "user", username: "canteen", email: "test_cant@email.com", encrypted_password: "$2a$11$SZFzp74ZZN3QA8IaDBJPgOU5CK5iqE3FR3Ba3UrzMou08rUamTdo.", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2018-07-28 08:26:49", last_sign_in_at: "2018-07-27 11:39:12", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
Menu.create!([
  {date: "2018-07-25", mealType: "lunch", firstCourse: "Carbonara", secondCourse: "Pollo", sideDish: "patate", notes: "vuoto", canteen_id: 3},
  {date: "2018-07-25", mealType: "dinner", firstCourse: "Amatriciana", secondCourse: "Manzo", sideDish: "faggiolini", notes: "vuoto", canteen_id: 3},
  {date: "2018-07-26", mealType: "lunch", firstCourse: "Pasta al pomodoro", secondCourse: "Salsiccia", sideDish: "Melanzane grigliate", notes: "note a caso", canteen_id: 3},
  {date: "2018-07-27", mealType: "lunch", firstCourse: "Pasta con il sugo di carne", secondCourse: "Carne al sugo", sideDish: "Polenta fritta", notes: "", canteen_id: 4},
  {date: "2018-07-28", mealType: "lunch", firstCourse: "Pasta fredda", secondCourse: "Arista con olive", sideDish: "Insalata mista", notes: "Vuoto", canteen_id: 4},
  {date: "2018-07-28", mealType: "dinner", firstCourse: "Pasta con zucchine e gamberetti", secondCourse: "Cordon bleu", sideDish: "Verdure lesse miste", notes: "Niente", canteen_id: 4}
])
Reservation.create!([
  {typeReservation: "student", firstCourseAlternatives: "pasta al sugo", secondCourseAlternatives: nil, sideDishAlternatives: "fettina", notes: "niente", student_id: 2, menu_id: 1}
])
Canteen.create!([
  {roles_mask: nil, type: "Canteen", first_name: "canteen", last_name: "user", username: "canteen", email: "test_cant@email.com", encrypted_password: "$2a$11$SZFzp74ZZN3QA8IaDBJPgOU5CK5iqE3FR3Ba3UrzMou08rUamTdo.", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2018-07-28 08:26:49", last_sign_in_at: "2018-07-27 11:39:12", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
Secretary.create!([
  {roles_mask: nil, type: "Secretary", first_name: "secretary", last_name: "user", username: "secretary", email: "test_sec@email.com", encrypted_password: "$2a$11$pxtiwkvDEK1J68zcJuqFbuXOCXgg5MU8fPc24atKQHhVuQ7/SCgmq", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil, last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil}
])
Student.create!([
  {roles_mask: nil, type: "Student", first_name: "student", last_name: "user", username: "student", email: "test_stud@email.com", encrypted_password: "$2a$11$KEUaJiN/RJMGoTHlfaftSuqeI3TgvnUhbPG9nP1URyEzfmmx8SGXG", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 2, current_sign_in_at: "2018-07-28 08:26:10", last_sign_in_at: "2018-07-27 17:44:00", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1"}
])
