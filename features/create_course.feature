Feature: Create a Course
  As a secretary
  I	want to create a course
  so that students can enroll

  Scenario: Create Crouse
    Given I am a secretary user
    And I have authorized the app to work with a drive account
    And I am on the courses page
    When I click on "Create a new Course"
    And I add the course information
    And I click on "Create course"
    Then The course should be created