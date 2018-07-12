Feature: Add Course Material
  As a secretary
  I want to add materials to a course
  so that students can study on them

  Scenario: Add Course Material
    Given I am a secretary user
    And I have authorized the app to work with a drive account
    Given There is at least a course
    Given There is at least a student
    And I am on a course enrollments page
    When I click on "Add a student"
    And I click on "Enroll"
    Then The student should be enrolled