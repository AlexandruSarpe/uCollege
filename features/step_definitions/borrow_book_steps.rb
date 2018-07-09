Given("I am an authenticated user ") do
  visit new_user_session_path
  email = "prova2@email.com"
  password = "prova2"
  Student.new(:email => email, :password => password, :password_confirmation => password).save!
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_on "Log in"


end

And("I am on the books page ") do
  visit books_path
end

Given("There is at least one listed book that I'm not the current owner of that book") do
  title = "libro6"
  description = "Avventura"
  author = "ignoto"
  email = "prova1@email.com"
  password = "prova1"
  Student.new(:email => email, :password => password, :password_confirmation => password).save!
  @student = Student.where(["email = ?", email]).first
  Book.new( :title => title,  :description => description, :author => author,  :owner_id => @student.id , :current_owner_id => @student.id).save!
end

When("I look at the information of the first listed book that I'm not the current owner") do
  title = "libro6"
  @book = Book.where(["title = ?", title]).first
  visit book_path(@book)
end

And("I click on {string} ") do |string|
  click_on string
end

Then("I should see my name as the current owner of that book") do
  title = "libro6"
  @book = Book.where(["title = ?", title]).first
  visit book_path(@book)
  expect(page).to have_content("prova2")
end
