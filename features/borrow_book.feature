Feature: I want to borrow a book
  As a student
  I want to borrow a book
  so that I can use it
Scenario: borrow a book
  Given I am an authenticated user
  And I am on the books page
  Given There is at least one listed book that I'm not the current owner of that book
  When I look at the information of the first listed book that I'm not the current owner
  And I click on "Borrow"
  Then I should be the current owner of that book
