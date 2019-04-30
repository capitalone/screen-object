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
  module AppElements

    class Element

      attr_reader :locator

      def initialize(locator)
        if locator.is_a?(String)
          warn "#{DateTime.now.strftime("%F %T")} WARN ScreenObject Element [DEPRECATION] Passing the locator as a single string with locator type and value sepaarted by ~ is deprecated and will no longer work in version 2.0.0. Use a hash instead (ex: button(:login, id: 'button_id') lib/screen-object/accessors/element.rb:#{__LINE__}"
          @locator=locator.split("~")
        elsif locator.is_a?(Hash)
          @locator=locator.first
        else
          raise "Invalid locator type: #{locator.class}"
        end
      end

      def driver
        $driver
      end

      def click
          element.click
      end

      def value
          element.value
      end

      def exists?
        begin
          element.displayed?
        rescue
          false
        end
      end

      def element
        driver.find_element(:"#{locator[0]}",locator[1])
      end

      def elements
        driver.find_elements(:"#{locator[0]}",locator[1])
      end

      def element_attributes
        %w[name resource-id value text]
      end

      def get_position
        my_element = element.rect
        {
            start_x: my_element.x,
            end_x: my_element.x + my_element.width,
            start_y: my_element.y,
            end_y: my_element.y + my_element.height,
            height: my_element.height,
            width: my_element.width
        }
      rescue RuntimeError => err
        raise("Error Details: #{err}")
      end

      def dynamic_xpath(text)
        concat_attribute=[]
        element_attributes.each{|i| concat_attribute << %Q(contains(@#{i}, '#{text}'))}
        puts  "//#{locator[0]}[#{concat_attribute.join(' or ')}]"
        locator1="xpath~//#{locator[0]}[#{concat_attribute.join(' or ')}]"
        @locator=locator1.split("~")
        element
      end

      def dynamic_text_exists? dynamic_text
        begin
          dynamic_xpath(dynamic_text).displayed?
        rescue
          false
        end
      end

      def gesture(args)
        Appium::TouchAction.new($driver).swipe(start_x: args[0], start_y: args[1], end_x: args[2], end_y: args[3], duration: args[4]).perform
      rescue RuntimeError => e
        raise("Error during gesture in element.rb\n Error Details: #{e}")
      end

      def scroll(direction = :down, duration = 1000)
        size = driver.window_size
        x = size.width / 2
        y = size.height / 2
        loc = (case direction
               when :up then    [x, y * 0.5, x, (y + (y * 0.5)), duration]
               when :down then  [x, y, x, y * 0.5, duration]
               when :left then  [x * 0.6, y, x * 0.3, y, duration]
               when :right then [x * 0.3, y, x * 0.6, y, duration]
               else
                 raise('Only upwards, downwards, leftwards and rightwards scrolling are supported')
               end)
        gesture(loc)
      end

      def scroll_down
        scroll(:down)
      end

      def scroll_up
        scroll(:up)
      end

      def swipe_left
        scroll(:left)
      end

      def swipe_right
        scroll(:right)
      end

      def swipe_my_element(direction = :down, duration = 1000)
        my_element = element.rect
        start_x = my_element.x
        end_x = my_element.x + my_element.width
        start_y = my_element.y
        end_y = my_element.y + my_element.height
        height = my_element.height
        loc = case direction
              when :up then    [end_x * 0.5, (start_y + (height * 0.2)), end_x * 0.5, (end_y - (height * 0.2)), duration]
              when :down then  [end_x * 0.5, (end_y - (height * 0.2)), start_x * 0.5, (start_y + (height * 0.3)), duration]
              when :left then  [end_x * 0.9,  end_y - (height / 2), start_x, end_y - (height / 2), duration]
              when :right then [end_x * 0.1, end_y - (height / 2), end_x * 0.9, end_y - (height / 2), duration]
              else
                raise('Only upwards and downwards scrolling are supported')
              end
        gesture(loc)
      end

      def scroll_element_down
        swipe_my_element(:down)
      end

      def scroll_element_up
        swipe_my_element(:up)
      end

      def swipe_element_left
        swipe_my_element(:left, 2000)
      end

      def swipe_element_right
        swipe_my_element(:right, 2000)
      end

      def scroll_to_text(text)
        $driver.scroll_to(text)
      end

      def scroll_to_exact_text(text)
        $driver.scroll_to_exact(text)
      end

      def scroll_for_element_click
        if element.displayed?
          element.click
        else
          scroll
          element.click
        end
      end

      def scroll_for_dynamic_element_click (expected_text)
        if dynamic_xpath(expected_text).displayed?
          element.click
        else
          scroll
          element.click
        end
      end

      def click_text(text)
        if exists?
          click
        else
          scroll_to_text(text)
          element.click
        end
      end

      def click_dynamic_text(text)
        if dynamic_text_exists?(text)
          element.click
        else
          scroll_to_text(text)
          element.click
        end
      end

      def click_exact_text(text)
        if exists?
          click
        else
          scroll_to_exact_text(text)
          element.click
        end
      end

      def click_dynamic_exact_text(text)
        if dynamic_text_exists?(text)
          element.click
        else
          scroll_to_exact_text(text)
          element.click
        end
      end

      def has_text(text)
        items = elements
        items.each do |item|
          text_value = item.attribute('text').strip
          return item if text_value.casecmp?(text.strip.to_s)
        end
        msg = "Unable to find element with text: #{text}"
        raise(msg)
      end

    end
  end
end
