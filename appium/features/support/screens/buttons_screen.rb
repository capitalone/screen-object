class ButtonsScreen
  
  include ScreenObject

  text(:title, "xpath~//UIAApplication[1]/UIAWindow[2]/UIANavigationBar[1]/UIAStaticText[1]")
  button(:text_button, "name~Button")
  button(:contact_add, "xpath~//UIAApplication[1]/UIAWindow[2]/UIATableView[1]/UIATableCell[2]")

end
