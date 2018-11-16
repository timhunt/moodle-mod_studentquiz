@mod @mod_studentquiz
Feature: Student Quiz activity creation
  To allow my students to set questions for each other
  As a teacher
  I need to add a Student Quiz activity to my course

  Scenario: Teacher can add a Student Quiz to a course
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher  | Terry     | Teacher  | teacher1@example.com |
      | student  | Sam       | Student  | student1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user    | course | role           |
      | teacher | C1     | editingteacher |
      | student | C1     | student        |
    When I log in as "teacher"
    And I am on "Course 1" course homepage with editing mode on
    And I add a "StudentQuiz" to section "1" and I fill the form with:
      | StudentQuiz Name | Test quiz name        |
      | Description      | Test quiz description |
    And I am on "Course 1" course homepage
    And I follow "Test quiz name"
    Then I should see "Create new question"

    # Check that the permission set up has worked, so a student can create a question here.
    And I log out
    And I log in as "student"
    And I am on "Course 1" course homepage
    And I follow "Test quiz name"
    And I press "Create new question"
    And I set the field "True/False" to "1"
    And I press "Add"
    And I set the following fields to these values:
      | Question name  | Is Student Quiz amazing  |
      | Question text  | Is Student Quiz amazing? |
      | Correct answer | True                     |
    And I press "id_submitbutton"
    And I should see "Sam Student" in the "Is Student Quiz amazing" "table_row"
