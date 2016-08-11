
When(/^I verify the count of table cells I should get an integer$/) do
  on(Screen).click_ui_catalog
  puts on(Screen).table_cell_count
end
