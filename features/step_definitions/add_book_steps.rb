Given("I am an authenticated user") do
  visit new_user_session_path
  email = "prova2@email.com"
  password = "prova2"
  Student.new(:email => email, :password => password, :password_confirmation => password).save!
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_on "Log in"


end

And("I am on the books page") do
  visit books_path
end

When("I click on {string}") do |string|
  click_link(string)
end

And("I add the information and click on {string}") do |string|
  title = "libro5"
  description = "Avventura"
  author = "ignoto"
  fill_in "book_title", :with => title
  fill_in "book_author", :with => author
  fill_in "book_description", :with => description
  click_on string

  visit books_path
  expect(page).to have_content("libro5")
end

Then("I should go to the books page and see the new book added") do
  visit books_path
  expect(page).to have_content("libro5")
end
