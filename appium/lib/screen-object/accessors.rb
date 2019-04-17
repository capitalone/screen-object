=begin
***********************************************************************************************************
SPDX-Copyright: Copyright (c) Capital One Services, LLC
SPDX-License-Identifier: Apache-2.0
Copyright 2016 Capital One Services, LLC
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the License. 
***********************************************************************************************************
=end

module ScreenObject
  include SupportUtil::Logger

  # contains  module level methods that are added into your screen objects.
  # when you include the ScreenObject module.  These methods will be generated as services for screens.

  # include Gem 'screen-object' into project Gemfile to add this Gem into project.
  # include require 'screen-object' into environment file. doing this , it will load screen object methods for usage..

  module Accessors

    def expected_element(element_name, timeout = 15)

      define_method("has_expected_element?") do
        raise "Element '#{element_name}' not defined on #{self.class}" unless self.respond_to? "#{element_name}_element"
        wait_until(timeout, "Expected element not present in #{timeout} seconds") do
          self.send("#{element_name}?")
        end
      end

      define_method("on_page?") do
        raise "Element '#{element_name}' not defined on #{self.class}" unless self.respond_to? "#{element_name}_element"
        self.send("#{element_name}?")
      end

    end

    # elements class generates all the methods related to general elements operation
    def element(name, locator)

      # generates method for checking the existence of the button.
      # this method will return true or false based on object displayed or not.
      # @example check if 'Submit' button exists on the screen.
      # button(:login_button,"xpath~//UIButtonField")
      # DSL to check existence of login button
      # def check_login_button
      #  login_button?  # This will return true or false based on existence of button.
      # end
      define_method("#{name}?") do
        debug "Checking for the existence of #{name}"
        ScreenObject::AppElements::Element.new(locator, driver).exists?
      end

      define_method("#{name}_element") do
        ScreenObject::AppElements::Element.new(locator, driver).element
      end

      # generates method for getting text for value attribute.
      # this method will return the text containing into value attribute.
      # @example To retrieve text from value attribute of the defined object i.e. 'Submit' button.
      # button(:login_button,"xpath~//UIButtonField")
      # DSL to retrieve text for value attribute.
      # def value_login_button
      #  login_button_value  # This will return the text of the value attribute of the 'Submit' button object.
      # end
      define_method("#{name}_value") do
        send("#{name}_text")
      end

      # generates method for checking if button is enabled.
      # this method will return true if button is enabled otherwise false.
      # @example check if 'Submit' button enabled on the screen.
      # button(:login_button,"xpath~//UIButtonField")
      # DSL to check if button is enabled or not
      # def enable_login_button
      # login_button_enabled? # This will return true or false if button is enabled or disabled.
      # end
      define_method("#{name}_enabled?") do
        debug "Checking if #{name} is enabled"
        ScreenObject::AppElements::Element.new(locator, driver).enabled?
      end

      # generates method for clicking on text object.
      # this will NOT return any value.
      # @example check if 'Welcome' text is displayed on the page
      # text(:welcome_text,"xpath~//UITextField")
      # DSL for clicking the Welcome text.
      # def click_welcome_text
      #   welcome_text # This will click on the Welcome text on the screen.
      # end
      define_method("#{name}") do
        send("#{name}_value")
      end

      define_method("#{name}_text") do
        debug "Getting text of #{name}"
        ScreenObject::AppElements::Element.new(locator, driver).text
      end

      # generates method for clicking on text object.
      # this will NOT return any value.
      # @example check if 'Welcome' text is displayed on the page
      # text(:welcome_text,"xpath~//UITextField")
      # DSL for clicking the Welcome text.
      # def click_welcome_text
      #   welcome_text # This will click on the Welcome text on the screen.
      # end
      define_method("#{name}_click") do
        info "Clicking on #{name}"
        wait_until(15, "#{name} was not clickable after 15 seconds.") do
          send("#{name}_enabled?")
        end
        ScreenObject::AppElements::Element.new(locator, driver).click
      end

      define_method("drag_#{name}_to") do |target|
        info "Dragging #{name} to #{target}"
        ScreenObject::AppElements::Element.new(locator, driver).drag_to(send("#{target}_element"))
      end

    end

    # Button class generates all the methods related to different operations that can be performed on the button.
    def button(name, locator)

      element(name, locator)

      # generates method for clicking button.
      # this method will not return any value.
      # @example click on 'Submit' button.
      # button(:login_button,"xpath~//UIButtonField")
      # def click_login_button
      #  login_button # This will click on the button.
      # end
      define_method(name) do
        send("#{name}_click")
      end

      # These methods need some rework, but aren't immediately necessary.
      # Should be implemented by AUT-1840 and AUT-1841

      # # generates method for scrolling on the screen and click on the button.
      # # this should be used for iOS platform.
      # # scroll to the first element with exact target static text or name.
      # # this method will not return any value.
      # # button(:login_button,"xpath~//UIButtonField")
      # # def scroll_button
      # #  login_button_scroll # This will not return any value. It will scroll on the screen until object found and click
      # #                        on the object i.e. button. This is iOS specific method and should not be used for android application
      # # end
      # define_method("#{name}_scroll") do
      #   # direction = options[:direction] || 'down'
      #   ScreenObject::AppElements::Button.new(locator, driver).scroll_for_element_click
      # end
      #
      # # generates method for scrolling on iOS application screen and click on button. This method should be used when button text is dynamic..
      # # this should be used for iOS platform.
      # # scroll to the first element with exact target dynamic text or name.
      # # this method will not return any value.
      # # @param [text] is the actual text of the button containing.
      # # DSL to scroll on iOS application screen and click on button. This method should be used when button text is dynamic..
      # # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
      # # OR
      # # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
      # # def scroll_button
      # #   login_button_scroll_dynamic(text)    # This will not return any value. we need to pass button text or name as parameter.
      # #                                          It will scroll on the screen until object with same name found and click on
      # #                                          the object i.e. button. This is iOS specific method and should not be used
      # #                                          for android application.
      # # end
      # define_method("#{name}_scroll_dynamic") do |text|
      #   # direction = options[:direction] || 'down'
      #   ScreenObject::AppElements::Button.new(locator, driver).scroll_for_dynamic_element_click(text)
      # end
      #
      # # generates method for scrolling on Android application screen and click on button. This method should be used when button text is static...
      # # this should be used for Android platform.
      # # scroll to the first element containing target static text or name.
      # # this method will not return any value.
      # # DSL to scroll on Android application screen and click on button. This method should be used when button text is static...
      # # @param [text] is the actual text of the button containing.
      # # button(:login_button,"xpath~//UIButtonField")
      # # def scroll_button
      # #   login_button_scroll_(text)  # This will not return any value. we need to pass button text or
      # #                                 name[containing targeted text or name] as parameter.It will scroll on the
      # #                                 screen until object with same name found and click on the
      # #                                 object i.e. button. This is Android specific method and should not be used
      # #                                 for iOS application. This method matches with containing text for the
      # #                                 button on the screen and click on it.
      # # end
      # define_method("#{name}_scroll_") do |text|
      #   ScreenObject::AppElements::Button.new(locator, driver).click_text(text)
      # end
      #
      # # generates method for scrolling on Android application screen and click on button. This method should be used when button text is dynamic......
      # # this should be used for Android platform.
      # # scroll to the first element containing target dynamic text or name.
      # # this method will not return any value.
      # # DSL to scroll on Android application screen and click on button. This method should be used when button text is dynamic......
      # # @param [text] is the actual text of the button containing.
      # # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
      # # OR
      # # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
      # #
      # # def scroll_button
      # #   login_button_scroll_dynamic_(text) # This will not return any value. we need to pass button text or name
      # #                                        [containing targeted text or name] as parameter.It will scroll on the screen
      # #                                        until object with same name found and click on the object i.e. button.
      # #                                        This is Android specific method and should not be used for iOS application.
      # #                                        This method matches with containing text for the button on the screen and click on it.
      # #
      # # end
      # define_method("#{name}_scroll_dynamic_") do |text|
      #   ScreenObject::AppElements::Button.new(locator, driver).click_dynamic_text(text)
      # end
      #
      # # generates method for scrolling on the screen and click on the button.
      # # this should be used for Android platform.
      # # scroll to the first element with exact target static text or name.
      # # this method will not return any value.
      # # DSL to scroll on Android application screen and click on button. This method should be used when button text is static. it matches with exact text.
      # # @param [text] is the actual text of the button containing.
      # # button(:login_button,"xpath~//UIButtonField")
      # # def scroll_button
      # #   login_button_scroll_exact_(text)       # This will not return any value. we need to pass button text or name
      # #                                            [EXACT text or name] as parameter. It will scroll on the screen until
      # #                                            object with same name found and click on the object i.e. button.
      # #                                            This is Android specific method and should not be used for iOS application.
      # #                                            This method matches with exact text for the button on the screen and click on it.
      # #
      # # end
      # define_method("#{name}_scroll_exact_") do |text|
      #   ScreenObject::AppElements::Button.new(locator, driver).click_exact_text(text)
      # end
      #
      # #generates method for scrolling on the screen and click on the button.
      # #This should be used for Android platform.
      # # Scroll to the first element with exact target dynamic text or name.
      # # this method will not return any value.
      # # DSL to scroll on Android application screen and click on button. This method should be used when button text is dynamic. it matches with exact text.
      # # @param [text] is the actual text of the button containing.
      # # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
      # # OR
      # # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
      # # def scroll_button
      # #   login_button_scroll_dynamic_exact_(text) # This will not return any value. we need to pass button text or name
      # #                                             [EXACT text or name] as parameter. It will scroll on the screen until object
      # #                                             with same name found and click on the object i.e. button. This is Android specific
      # #                                             method and should not be used for iOS application. This method matches with exact
      # #                                             text for the button on the screen and click on it.
      # #
      # # end
      # define_method("#{name}_scroll_dynamic_exact_") do |text|
      #   ScreenObject::AppElements::Button.new(locator, driver).click_dynamic_exact_text(text)
      # end

    end

    # end of button class.

    # Checkbox class generates all the methods related to different operations that can be performed on the check box on the screen.
    def checkbox(name, locator)

      element(name, locator)

      # generates method for checking the checkbox object.
      # this will not return any value
      # @example check if 'remember me' checkbox is not checked.
      # checkbox(:remember_me,"xpath~//UICheckBox")
      # DSL to check the 'remember me' check box.
      # def check_remember_me_checkbox
      #   check_remember_me # This method will check the check box.
      # end
      define_method("check_#{name}") do
        info "Checking #{name}"
        ScreenObject::AppElements::CheckBox.new(locator, driver).check
      end

      # generates method for un-checking the checkbox.
      # this will not return any value
      # @example uncheck if 'remember me' check box is checked.
      # DSL to uncheck remember me check box
      # def uncheck_remember_me_check_box
      #   uncheck_remember_me # This method will uncheck the check box if it's checked.
      # end
      define_method("uncheck_#{name}") do
        info "Unchecking #{name}"
        ScreenObject::AppElements::CheckBox.new(locator, driver).uncheck
      end

      # generates method for checking if checkbox is already checked.
      # this will return true if checkbox is checked.
      # @example check if 'remember me' check box is not checked.
      # def exist_remember_me_check_box
      #   remember_me? # This method is used to return true or false based on 'remember me' check box exist.
      # end
      define_method("#{name}_checked?") do
        debug "Determining if #{name} is checked"
        ScreenObject::AppElements::CheckBox.new(locator, driver).checked?
      end

      define_method("#{name}_value") do
        debug "Determining if #{name} is checked or unchecked"
        send("#{name}_checked?") ? 'checked' : 'unchecked'
      end

    end


    # Text class generates all the methods related to different operations that can be performed on the text object on the screen.
    def text(name, locator)

      element(name, locator)

      # generates method for checking dynamic text object.
      # this will return true or false based on object is displayed or not.
      # @example check if 'Welcome' text is displayed on the page
      # @param [text] is the actual text of the button containing.
      # suppose 'Welcome guest' text appears on the screen for non logged in user and it changes when user logged in on the screen and appears as 'Welcome <guest_name>'. this would be treated as dynamic text since it would be changing based on guest name.
      # DSL to check if the text that is sent as argument exists on the screen. Returns true or false
      # text(:welcome_guest,"xpath~//UITextField")
      # def dynamic_welcome_guest(Welcome_<guest_name>)
      # welcome_text_dynamic?(welcome_<guest_name>)  # This will return true or false based welcome text exists on the screen.
      # end
      define_method("#{name}_dynamic?") do |text|
        debug "Determining if #{name} is dynamic"
        ScreenObject::AppElements::Text.new(locator, driver).dynamic_text_exists?(text)
      end

      # generates method for checking dynamic text object.
      # this will return actual test for an object.
      # @example check if 'Welcome' text is displayed on the page
      # @param [text] is the actual text of the button containing.
      # suppose 'Welcome guest' text appears on the screen for non logged in user and it changes when user logged in on the screen and appears as 'Welcome <guest_name>'. this would be treated as dynamic text since it would be changing based on guest name.
      # DSL to check if the text that is sent as argument exists on the screen. Returns true or false
      # text(:welcome_guest,"xpath~//UITextField")
      # def dynamic_welcome_guest(Welcome_<guest_name>)
      # welcome_text_dynamic?(welcome_<guest_name>)  # This will return true or false based welcome text exists on the screen.
      # end
      define_method("#{name}_dynamic_text") do |text|
        debug "Getting dynamic text of #{name}"
        ScreenObject::AppElements::Text.new(locator, driver).dynamic_text(text)
      end

    end

    # text_field class generates all the methods related to different operations that can be performed on the text_field object on the screen.
    def text_field(name, locator)

      element(name, locator)

      # generates method for setting text into text field.
      # There is no return value for this method.
      # @example setting username field.
      # DSL for entering text in username text field.
      # def set_username_text_field(username)
      #   self.username=username   # This method will enter text into username text field.
      # end
      define_method("#{name}=") do |text|
        info "Setting #{name} to '#{text}'"
        ScreenObject::AppElements::TextField.new(locator, driver).text = (text)
      end

      # generates method for clear pre populated text from the text field.
      # this will not return any value.
      # @example clear text of the username text field.
      # text_field(:username,"xpath~//UITextField")
      # DSL to clear the text of the text field.
      # def clear_text
      #   clear_username # This will clear the pre populated user name text field.
      # end
      define_method("clear_#{name}") do
        info "Clearing #{name}"
        ScreenObject::AppElements::TextField.new(locator, driver).clear
      end

    end


    # Image class generates all the methods related to different operations that can be performed on the image object on the screen.
    def image(name, locator)

      element(name, locator)

      #generates method for clicking image
      # this will not return any value.
      # @example clicking on logo image.
      # text(:logo,"xpath~//UITextField")
      # DSL for clicking the logo image.
      # def click_logo
      #  logo # This will click on the logo text on the screen.
      # end
      define_method("#{name}") do
        send("#{name}_click")
      end
    end

    # table class generates all the methods related to different operations that can be performed on the table object on the screen.
    def table(name, locator)

      element(name, locator)

      #generates method for counting total no of cells in table
      define_method("#{name}_cell_count") do
        debug "Getting Cell Count for #{name}"
        ScreenObject::AppElements::Table.new(locator, driver).cell_count
      end
    end

  end # end of Accessors module
end # end of screen object module
