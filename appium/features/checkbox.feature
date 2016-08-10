Feature: CheckBox
  In order to access the checkbox functionality
  we need to test all the operations

  Background:
    Given I am on login page

  Scenario: Verify the checkbox exists
    When I verify the existence of the checkbox
    Then I should see the return value as true on checkbox existence
