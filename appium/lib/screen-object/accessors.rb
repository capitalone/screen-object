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

  # contains  module level methods that are added into your screen objects.
  # when you include the ScreenObject module.  These methods will be generated as services for screens.

  # include Gem 'screen-object' into project Gemfile to add this Gem into project.
  # include require 'screen-object' into environment file. doing this , it will load screen object methods for usage..

  module Accessors

    # Button class generates all the methods related to different operations that can be performed on the button.
    def button(name, locator)

        # generates method for clicking button.
        # this method will not return any value.
        # @example click on 'Submit' button.
        # button(:login_button,"xpath~//UIButtonField")
        # def click_login_button
        #  login_button # This will click on the button.
        # end
        define_method(name) do
          ScreenObject::AppElements::Button.new(locator).tap
        end

        # generates method for checking the existence of the button.
        # this method will return true or false based on object displayed or not.
        # @example check if 'Submit' button exists on the screen.
        # button(:login_button,"xpath~//UIButtonField")
        # DSL to check existence of login button
        # def check_login_button
        #  login_button?  # This will return true or false based on existence of button.
        # end
        define_method("#{name}?") do
          ScreenObject::AppElements::Button.new(locator).exists?
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
          ScreenObject::AppElements::Button.new(locator).enabled?
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
          ScreenObject::AppElements::Button.new(locator).value
        end

        # generates method for scrolling on the screen and click on the button.
        # this should be used for iOS platform.
        # scroll to the first element with exact target static text or name.
        # this method will not return any value.
        # button(:login_button,"xpath~//UIButtonField")
        # def scroll_button
        #  login_button_scroll # This will not return any value. It will scroll on the screen until object found and click
        #                        on the object i.e. button. This is iOS specific method and should not be used for android application
        # end
        define_method("#{name}_scroll") do
          # direction = options[:direction] || 'down'
          ScreenObject::AppElements::Button.new(locator).scroll_for_element_click
        end

        # generates method for scrolling on iOS application screen and click on button. This method should be used when button text is dynamic..
        # this should be used for iOS platform.
        # scroll to the first element with exact target dynamic text or name.
        # this method will not return any value.
        # @param [text] is the actual text of the button containing.
        # DSL to scroll on iOS application screen and click on button. This method should be used when button text is dynamic..
        # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
        # OR
        # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
        # def scroll_button
        #   login_button_scroll_dynamic(text)    # This will not return any value. we need to pass button text or name as parameter.
        #                                          It will scroll on the screen until object with same name found and click on
        #                                          the object i.e. button. This is iOS specific method and should not be used
        #                                          for android application.
        # end
        define_method("#{name}_scroll_dynamic") do |text|
          # direction = options[:direction] || 'down'
          ScreenObject::AppElements::Button.new(locator).scroll_for_dynamic_element_click(text)
        end

        # generates method for scrolling on Android application screen and click on button. This method should be used when button text is static...
        # this should be used for Android platform.
        # scroll to the first element containing target static text or name.
        # this method will not return any value.
        # DSL to scroll on Android application screen and click on button. This method should be used when button text is static...
        # @param [text] is the actual text of the button containing.
        # button(:login_button,"xpath~//UIButtonField")
        # def scroll_button
        #   login_button_scroll_(text)  # This will not return any value. we need to pass button text or
        #                                 name[containing targeted text or name] as parameter.It will scroll on the
        #                                 screen until object with same name found and click on the
        #                                 object i.e. button. This is Android specific method and should not be used
        #                                 for iOS application. This method matches with containing text for the
        #                                 button on the screen and click on it.
        # end
        define_method("#{name}_scroll_") do |text|
          ScreenObject::AppElements::Button.new(locator).click_text(text)
        end

        # generates method for scrolling on Android application screen and click on button. This method should be used when button text is dynamic......
        # this should be used for Android platform.
        # scroll to the first element containing target dynamic text or name.
        # this method will not return any value.
        # DSL to scroll on Android application screen and click on button. This method should be used when button text is dynamic......
        # @param [text] is the actual text of the button containing.
        # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
        # OR
        # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
        #
        # def scroll_button
        #   login_button_scroll_dynamic_(text) # This will not return any value. we need to pass button text or name
        #                                        [containing targeted text or name] as parameter.It will scroll on the screen
        #                                        until object with same name found and click on the object i.e. button.
        #                                        This is Android specific method and should not be used for iOS application.
        #                                        This method matches with containing text for the button on the screen and click on it.
        #
        # end
        define_method("#{name}_scroll_dynamic_") do |text|
          ScreenObject::AppElements::Button.new(locator).click_dynamic_text(text)
        end

        # generates method for scrolling on the screen and click on the button.
        # this should be used for Android platform.
        # scroll to the first element with exact target static text or name.
        # this method will not return any value.
        # DSL to scroll on Android application screen and click on button. This method should be used when button text is static. it matches with exact text.
        # @param [text] is the actual text of the button containing.
        # button(:login_button,"xpath~//UIButtonField")
        # def scroll_button
        #   login_button_scroll_exact_(text)       # This will not return any value. we need to pass button text or name
        #                                            [EXACT text or name] as parameter. It will scroll on the screen until
        #                                            object with same name found and click on the object i.e. button.
        #                                            This is Android specific method and should not be used for iOS application.
        #                                            This method matches with exact text for the button on the screen and click on it.
        #
        # end
        define_method("#{name}_scroll_exact_") do |text|
          ScreenObject::AppElements::Button.new(locator).click_exact_text(text)
        end

        # generates method for scrolling on the screen and click on the button.
        # This should be used for Android platform.
        # Scroll to the first element with exact target dynamic text or name.
        # this method will not return any value.
        # DSL to scroll on Android application screen and click on button. This method should be used when button text is dynamic. it matches with exact text.
        # @param [text] is the actual text of the button containing.
        # button(:login_button,"UIButtonField")  # button API should have class name as shown in this example.
        # OR
        # button(:login_button,"UIButtonField/UIButtonFieldtext")  # button API should have class name as shown in this example.
        # def scroll_button
        #   login_button_scroll_dynamic_exact_(text) # This will not return any value. we need to pass button text or name
        #                                             [EXACT text or name] as parameter. It will scroll on the screen until object
        #                                             with same name found and click on the object i.e. button. This is Android specific
        #                                             method and should not be used for iOS application. This method matches with exact
        #                                             text for the button on the screen and click on it.
        #
        # end
        define_method("#{name}_scroll_dynamic_exact_") do |text|
          ScreenObject::AppElements::Button.new(locator).click_dynamic_exact_text(text)
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::Button]
        # button(:login_button,"xpath~//UIButtonField)
        # def get_login_button_element
        #   login_button_element # This will not return the underlying ScreenObject::AppElements::Button object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::Button.new(locator)
        end
    end   # end of button class.

    # Checkbox class generates all the methods related to different operations that can be performed on the check box on the screen.
    def checkbox(name, locator)

        # generates method for checking the checkbox object.
        # this will not return any value
        # @example check if 'remember me' checkbox is not checked.
        # checkbox(:remember_me,"xpath~//UICheckBox")
        # DSL to check the 'remember me' check box.
        # def check_remember_me_checkbox
        #   check_remember_me # This method will check the check box.
        # end
        define_method("check_#{name}") do
          ScreenObject::AppElements::CheckBox.new(locator).check
        end

        # generates method for un-checking the checkbox.
        # this will not return any value
        # @example uncheck if 'remember me' check box is checked.
        # DSL to uncheck remember me check box
        # def uncheck_remember_me_check_box
        #   uncheck_remember_me # This method will uncheck the check box if it's checked.
        # end
        define_method("uncheck_#{name}") do
          ScreenObject::AppElements::CheckBox.new(locator).uncheck
        end

        # generates method for checking the existence of object.
        # this will return true or false based on object is displayed or not.
        # @example check if 'remember me' check box exists on the screen.
        # def exist_remember_me_check_box
        #   remember_me? # This method is used to return true or false based on 'remember me' check box exist.
        # end
        define_method("#{name}?") do
          ScreenObject::AppElements::CheckBox.new(locator).exists?
        end

        # generates method for checking if checkbox is already checked.
        # this will return true if checkbox is checked.
        # @example check if 'remember me' check box is not checked.
        # def exist_remember_me_check_box
        #   remember_me? # This method is used to return true or false based on 'remember me' check box exist.
        # end
        define_method("#{name}_checked?") do
          ScreenObject::AppElements::CheckBox.new(locator).checked?
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::CheckBox]
        # checkbox(:remember_me,"xpath~//UICheckBox")
        # def get_remember_me_element
        #   remember_me_element # This will not return the underlying ScreenObject::AppElements::CheckBox object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::CheckBox.new(locator)
        end
      end


      # Text class generates all the methods related to different operations that can be performed on the text object on the screen.
      def text(name,locator)

        # generates method for clicking button.
        # this method will not return any value.
        # @example click on 'Submit' button.
        # button(:login_button,"xpath~//UIButtonField")
        # def click_login_button
        #  login_button # This will click on the button.
        # end
        define_method(name) do
          ScreenObject::AppElements::Text.new(locator).tap
        end

        # generates method for checking if text exists on the screen.
        # this will return true or false based on if text is available or not
        # @example check if 'Welcome' text is displayed on the page
        # text(:welcome_text,"xpath~//UITextField")
        # # DSL for clicking the Welcome text.
        # def verify_welcome_text
        #   welcome_text? # This will check if object exists and return true..
        # end
        define_method("#{name}?") do
          ScreenObject::AppElements::Text.new(locator).exists?
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
          ScreenObject::AppElements::Text.new(locator).click
        end

        # generates method for retrieving text of the object.
        # this will return value of text attribute of the object.
        # @example retrieve text of 'Welcome' object on the page.
        # text(:welcome_text,"xpath~//UITextField")
        # DSL to retrieve text of the attribute text.
        # def get_welcome_text
        #   welcome_text_text # This will return text of value of attribute 'text'.
        # end
        define_method("#{name}_text") do
          ScreenObject::AppElements::Text.new(locator).text
        end

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
          ScreenObject::AppElements::Text.new(locator).dynamic_text_exists?(text)
        end

        # generates method for retrieving text of the value attribute of the object.
        # this will return text of value attribute of the object.
        # @example retrieve text of the 'Welcome' text.
        # text(:welcome_text,"xpath~//UITextField")
        # DSL to retrieve text of the attribute text.
        # def get_welcome_text
        #   welcome_text_value # This will return text of value of attribute 'text'.
        # end
        define_method("#{name}_value") do
          ScreenObject::AppElements::Text.new(locator).value
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
          ScreenObject::AppElements::Text.new(locator).dynamic_text(text)
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::Text]
        # text(:welcome_text,"xpath~//UITextField")
        # def get_welcome_text_element
        #   welcome_text_element # This will not return the underlying ScreenObject::AppElements::Text object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::Text.new(locator)
        end
      end

      # text_field class generates all the methods related to different operations that can be performed on the text_field object on the screen.
      def text_field(name,locator)

        # generates method for setting text into text field.
        # There is no return value for this method.
        # @example setting username field.
        # DSL for entering text in username text field.
        # def set_username_text_field(username)
        #   self.username=username   # This method will enter text into username text field.
        # end
        define_method("#{name}=") do |text|
          ScreenObject::AppElements::TextField.new(locator).text=(text)
        end

        # generates method for comparing expected and actual text.
        # this will return text of text attribute of the object.
        # @example retrieve text of the 'username' text field.
        # text_field(:username,"xpath~//UITextField")
        # DSL to retrieve text of the attribute text.
        # def get_welcome_text
        #   username_text # This will return text containing in text field attribute.
        # end
        define_method("#{name}") do
          ScreenObject::AppElements::TextField.new(locator).text
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
          ScreenObject::AppElements::TextField.new(locator).clear
        end

        # generates method for checking if text_field exists on the screen.
        # this will return true or false based on if text field is available or not
        # @example check if 'username' text field is displayed on the page
        # text_field(:username,"xpath~//UITextField")
        # # DSL for clicking the username text.
        # def exists_username
        #   username? # This will return if object exists on the screen.
        # end
        define_method("#{name}?") do
          ScreenObject::AppElements::TextField.new(locator).exists?
        end

        # generates method for retrieving text of the value attribute of the object.
        # this will return text of value attribute of the object.
        # @example retrieve text of the 'username' text_field.
        # text_field(:username,"xpath~//UITextField")
        # DSL to retrieve text of the attribute text.
        # def get_username_text
        #   username_value # This will return text of value of attribute 'text'.
        # end
        define_method("#{name}_value") do
          ScreenObject::AppElements::TextField.new(locator).value
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
          ScreenObject::AppElements::TextField.new(locator).enabled?
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::TextField]
        # text_field(:username,"xpath~//UITextField")
        # def get_username_element
        #   username_element # This will not return the underlying ScreenObject::AppElements::TextField object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::TextField.new(locator)
        end
      end


      # Image class generates all the methods related to different operations that can be performed on the image object on the screen.
      def image(name,locator)

        # generates method for checking the existence of the image.
        # this will return true or false based on if image is available or not
        # @example check if 'logo' image is displayed on the page
        # text(:logo,"xpath~//UITextField")
        # DSL for clicking the logo image.
        # def click_logo
        #  logo # This will click on the logo text on the screen.
        # end
        define_method("#{name}?") do
          ScreenObject::AppElements::Image.new(locator).exists?
        end

        #generates method for clicking image
        # this will not return any value.
        # @example clicking on logo image.
        # text(:logo,"xpath~//UITextField")
        # DSL for clicking the logo image.
        # def click_logo
        #  logo # This will click on the logo text on the screen.
        # end
        define_method("#{name}") do
          ScreenObject::AppElements::Image.new(locator).click
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::Image]
        # image(:logo,"id~mainLogo")
        # def get_logo_element
        #   logo_element # This will not return the underlying ScreenObject::AppElements::Image object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::Image.new(locator)
        end
      end

      # table class generates all the methods related to different operations that can be performed on the table object on the screen.
      def table(name, locator)
        #generates method for counting total no of cells in table
        define_method("#{name}_cell_count") do
          ScreenObject::AppElements::Table.new(locator).cell_count
        end

        # returns the underlying ScreenObject element to allow
        # use of all inherited AppElements::Element methods
        # this also makes it more consistent with PageObject gem
        # which provides a _element method for any type of accessor
        # @return [ScreenObject::AppElements::Table]
        # table(:monthly_statement,"id~monthStatement")
        # def get_monthly_statement_element
        #   monthly_statement_element # This will not return the underlying ScreenObject::AppElements::Table object
        #                  which can use all the inherited methods of ScreenObject::AppElements::Element
        #                  like: .click, .value, .element etc. which are needed in certain cases
        # end
        define_method("#{name}_element") do
          ScreenObject::AppElements::Table.new(locator)
        end
      end

      # elements class generates all the methods related to general elements operation
      def element(name, locator)
        #generates method for elements object
        define_method("#{name}") do
          ScreenObject::AppElements::Element.new(locator)
        end
      end

  end # end of Accessors module
end # end of screen object module
