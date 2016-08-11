When(/^I navigate to the buttons screen$/) do
  navigate_to(ButtonsScreen)
end

Then(/^the title for the buttons screen should be "([^"]*)"$/) do |title|
  on(ButtonsScreen).title_text.should == title
end

Then(/^I should be able to click several buttons$/) do
  on(ButtonsScreen) do |screen|
    screen.text_button
    screen.contact_add
  end
end
