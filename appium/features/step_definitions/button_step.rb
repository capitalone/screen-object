
Given(/^I am on UICatalog screen$/) do

end

When(/^I verify the existence of the button$/) do
 puts "Checking for the existence of button using exists method. Should be true.  --  #{on(Screen).ui_catalog_exists?}"

end

Then(/^I should see the return value as true on button existence$/) do
  fail unless on(Screen).ui_catalog_exists?
end

When(/^I verify the existence of the button that is not present$/) do
  puts "Checking for the existence of button using exist method. Should be false  --  #{on(Screen).no_button_exists?}"
end


Then(/^I should see the return value as false on button existence$/) do
  fail unless !on(Screen).no_button_exists?
end

When(/^I verify the existence of the button using isenabled method return value should be true$/) do
  puts "Checking for the existence of button using enabled method.Should be true  --  #{on(Screen).is_ui_catalog_enabled}"
  fail unless on(Screen).is_ui_catalog_enabled
end

When(/^I verify the existence of the button using isenabled method return value should be false$/) do
  puts "Checking for the existence of button using enabled method. should be false  --  #{on(Screen).no_button_exists?}"
  fail unless !on(Screen).no_button_exists?
end

When(/^I click the UICatalog button$/) do
  on(Screen).click_ui_catalog
  sleep 2
end

Then(/^I should see the message to confirm the button is clicked$/) do

end

When(/^I click the button that does not exist$/) do
  puts '1'
  on(Screen).no_button_click
  puts on(Screen).no_button_click
end
