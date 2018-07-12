Given("I am an authenticated user ") do
  visit new_user_session_path
  @student = FactoryBot.create(:student1)
  fill_in "user_email", :with => @student.email
  fill_in "user_password", :with => @student.password
  click_on "Log in"
end

And("I am on the books page ") do
  visit books_path
end

Given("There is at least one listed book that I'm not the current owner of that book") do
  @student2 = FactoryBot.create(:student2)
  @book = FactoryBot.create(:book1)
  @book.update(:owner_id => @student2.id , :current_owner_id => @student2.id)
end

When("I look at the information of the first listed book that I'm not the current owner") do
  visit book_path(@book)
end

And("I click on {string} ") do |string|
  click_on string
end

Then("I should be the current owner of that book") do
  @book.reload
  expect(@book.current_owner_id).to eq(@student.id)
end
