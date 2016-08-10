Feature: Adding navigation capabilities to the screen-object

  Scenario: Navigating to a screen
    When I navigate to the buttons screen
    Then the title for the buttons screen should be "Buttons"

  Scenario: Doing multiple things on a page
    When I navigate to the buttons screen
    Then I should be able to click several buttons
