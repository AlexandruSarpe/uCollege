Feature: I want to create a new book
  As a student
  I want to add a new book
  so that I can share it

Scenario: create a book
  Given I am on the books page
  When I click on "add a book"
  Given I am on the books creation page
  When I add the information and click on "add book"
  Then I should go to the books page and see the new book added
