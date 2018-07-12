Given("I am an authenticated user") do
  visit new_user_session_path
  @student = FactoryBot.create(:student1)
  fill_in "user_email", :with => @student.email
  fill_in "user_password", :with => @student.password
  click_on "Log in"


end

And("I am on the books page") do
  visit books_path
end

When("I click on {string}") do |string|
  click_link(string)
end

And("I add the information and click on {string}") do |string|
  @title = "Book1"
  description = "Poetry"
  author = "Moravia"
  fill_in "book_title", :with => @title
  fill_in "book_author", :with => author
  fill_in "book_description", :with => description
  click_on string
end

Then("The book should be created") do
  @book = Book.where(["title = ?", @title]).first
  expect(@book).to_not be(nil)
end
