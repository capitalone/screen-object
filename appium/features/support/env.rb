require 'rspec'
require 'appium_lib'
require 'cucumber/ast'
require 'require_all'
require 'screen-object'

require_relative 'screen'
require_rel 'screens'

appium_txt = IO.readlines(File.dirname(File.expand_path('./', __FILE__)) + "/appium.txt")
path = appium_txt[3].split(34.chr)
$AppPath = path[1]
Appium::Driver.new(Appium.load_appium_txt file: File.expand_path('./', __FILE__), verbose: true)

Before {
  ScreenObject::Load_App.start_driver
}

After {
  ScreenObject::Load_App.quit_driver
}

World(ScreenObject::ScreenFactory)


ScreenObject::ScreenFactory.routes = {
    default: [[LandingScreen, :go_to_main_screen],
              [MainScreen, :go_to_buttons_screen],
              [ButtonsScreen, :title]]
}
