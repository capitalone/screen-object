Feature: Button
  In order to access the buttons functionality
  we need to test all the operations

  Background:
    Given I am on UICatalog screen

  Scenario: Verify the button exists
    When I verify the existence of the button
    Then I should see the return value as true on button existence

  #Scenario: Verify the output when button doesn't exist
  #  When I verify the existence of the button that is not present
   # Then I should see the return value as false on button existence

  Scenario: Click the button
    When I click the UICatalog button
    Then I should see the message to confirm the button is clicked

  #Scenario: Click the button that does not exist
   # When I click the button that does not exist

  Scenario: Verify if the value is true when verifying the isenabled method
    When I verify the existence of the button using isenabled method return value should be true

  Scenario: Verify if the value is false when verifying the isenabled method for disabled button
    When I verify the existence of the button using isenabled method return value should be false
