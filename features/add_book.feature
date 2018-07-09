Feature: I want to create a new book
  As a student
  I want to add a new book
  so that I can share it

Scenario: create a book
  Given I am an authenticated user
  And I am on the books page
  When I click on "Add book"
  And I add the information and click on "Save"
  Then The book should be created
