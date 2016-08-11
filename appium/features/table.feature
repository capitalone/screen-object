#UIAApplication[1]/UIAWindow[2]/UIATableView[1]

Feature: Table
  In order to access the table functionality
  we need to test all the operations

  Background:
    Given I am on UICatalog screen

  Scenario: Verify the table cell count method
    When I verify the count of table cells I should get an integer
