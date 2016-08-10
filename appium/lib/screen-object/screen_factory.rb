require 'page_navigation'

module ScreenObject

  #
  # Module to facilitate to creating of screen objects in step definitions.  You
  # can make the methods below available to all of your step definitions by adding
  # this module to World.
  #
  # @example Making the ScreenFactory available to your step definitions
  #   World ScreenObject::ScreenFactory
  #
  # @example using a screen in a Scenario
  #   on MyScreenObject do |screen|
  #     screen.name = 'Cheezy'
  #   end
  #
  # If you plan to use the navigate_to method you will need to ensure
  # you setup the possible routes ahead of time.  You must always have
  # a default route in order for this to work.  Here is an example of
  # how you define routes:
  #
  # @example Example routes defined in env.rb
  #   ScreenObject::ScreenFactory.routes = {
  #     :default => [[ScreenOne,:method1], [ScreenTwoA,:method2], [ScreenThree,:method3]],
  #     :another_route => [[ScreenOne,:method1, "arg1"], [ScreenTwoB,:method2b], [ScreenThree,:method3]]
  #   }
  #
  # Notice the first entry of :another_route is passing an argument
  # to the method.
  #


  module ScreenFactory
    include PageNavigation

    def on(screen_class, &blk)
      @current_screen = screen_class.new
      blk.call @current_screen if blk
      @current_screen
    end

  end
end
