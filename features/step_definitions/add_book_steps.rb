Given("I am on the books page") do
  #visit books_page
end

When("I click on {string}") do |string|
  #click_link(string)
end

Given("I am on the books creation page") do
  #visit bookscreation_page
end

When("I add the information and click on {string}") do |string|
  #click_link
end

Then("I should go to the books page and see the new book added") do
  #expect(page).to have_content
end
