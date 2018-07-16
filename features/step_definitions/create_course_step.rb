# frozen_string_literal: true

Given('I am a secretary user') do
  secretary = FactoryBot.create(:secretary)
  visit new_user_session_path
  fill_in 'user_email', with: secretary.email
  fill_in 'user_password', with: secretary.password
  click_on 'Log in'
end

And('I have authorized the app to work with a drive account') do
  Token.create access_token: ENV['Drive_at'], refresh_token: ENV['Drive_rt'], expires_at: ENV['Drive_exp']
end

And('I am on the courses page') do
  visit courses_path
end

When('I click on {string}') do |string|
  click_on(string)
end

And('I add the course information') do
  name = 'New Course'
  begin_year = '2017'
  end_year = '2018'
  fill_in 'course_name', with: name
  fill_in 'course_begin_year', with: begin_year
  fill_in 'course_end_year', with: end_year
end

Then('The course should be created') do
  name = 'New Course'
  @course = Course.where('name = ?', name).first
  expect(@course).to_not be(nil)
end
