# frozen_string_literal: true

include Material
Given('There is at least a course') do
  name = 'Another New Course'
  begin_year = '2017'
  end_year = '2018'
  if Course.where('name=? and begin_year=? and end_year=?', name, begin_year, end_year).empty?
    material = create_folder "#{name} #{begin_year}-#{end_year}"
    Course.create name: name, begin_year: begin_year, end_year: end_year,
                  material: material
  end
end

And('I am on a course enrollments page') do
  course = Course.last
  visit "/courses/#{course.id}/enrollments"
end

Given('There is at least a student') do
  Student.create first_name: 'Student', last_name: 'user',
                 username: 'student', email: 'test_stud@email.com',
                 password: 'testing'
end

Then('The student should be enrolled') do
  course = Course.where('name=\'Another New Course\' and begin_year=2017 and end_year=2018').first
  student = course.students.where('email= \'test_stud@email.com\'').first
  expect(student).to_not be nil
end
