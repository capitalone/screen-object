class Screen
  include ScreenObject

  #ios
  button(:ui_catalog, "name~UICatalog")
  button(:no_button, "name~nobutton")
  text(:ui_catalog_text, "xpath~//UIAStaticText[@name='UICatalog']")
  text_field(:username, "xpath~//UIAApplication[1]/UIAWindow[1]/UIAScrollView[1]/UIATextField[1]")
  text_field(:no_textfield, "name~notextfield")
  checkbox(:remember, "id~c/rememberMe")
  table(:table_view, 'xpath~UIAApplication[1]/UIAWindow[2]/UIATableView[1]')

  # Button methods

  def table_cell_count
    table_view_cell_count
  end

  def remember_me?
    remember?
  end

  def remember_me_checked?
    remember_checked?
  end

  def remember_me_uncheck
    check_remember
  end

  def ui_catalog_exists?
    ui_catalog?
  end


  def no_button_exists?
    no_button?
  end

  def no_button_click
    no_button
  end

  def enter_username(atext)
    self.username=atext
  end

  def get_username
    username
  end

  def username_exists?
    username?
  end

  def no_textfield_exists?
    no_textfield?
  end

  def is_ui_catalog_enabled
    ui_catalog_enabled?
  end

  def is_nobutton_enabled
    no_button_isenabled?
  end

  def click_ui_catalog
    ui_catalog
  end
end

# Text Methods

def UICatalog_text?
  ui_catalog_text?
end

# Table Methods
