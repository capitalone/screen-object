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

      attr_reader :locator, :driver

      def initialize(locator, driver)
        @driver = driver
        if locator.is_a?(String)
          @locator = locator.split("~")
        elsif locator.is_a?(Hash)
          locator_key = get_locator(locator)
          @locator = [locator_key, locator[locator_key]]
        else
          raise("Locator must be in the form of a String or a Hash")
        end
      end

      def get_locator(locator)
        locator.each_key do |key|
          return key if locators.include?(key.to_sym)
        end
        raise("No valid locators found. Valid locators are #{locators}")
      end

      def locators
        [
            :class,
            :class_name,
            :css,
            :id,
            :link,
            :link_text,
            :name,
            :partial_link_text,
            :tag_name,
            :xpath,
            :accessibility_id,
            :image,
            :custom,
            :uiautomator,
            :viewtag,
            :uiautomation,
            :predicate,
            :class_chain,
            :windows_uiautomation,
            :tizen_uiautomation
        ]
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
        driver.find_element(:"#{locator[0]}", locator[1])
      end

      def elements
        driver.find_elements(:"#{locator[0]}", locator[1])
      end

      def element_attributes
        %w[name resource-id value text]
      end

      def dynamic_xpath(text)
        concat_attribute = []
        element_attributes.each {|i| concat_attribute << %Q(contains(@#{i}, '#{text}'))}
        puts "//#{locator[0]}[#{concat_attribute.join(' or ')}]"
        locator1 = "xpath~//#{locator[0]}[#{concat_attribute.join(' or ')}]"
        @locator = locator1.split("~")
        element
      end

      def dynamic_text_exists? dynamic_text
        begin
          dynamic_xpath(dynamic_text).displayed?
        rescue
          false
        end
      end

      def scroll
        @driver.execute_script 'mobile: scrollTo', :element => element.ref
        # @driver.execute_script("mobile: scroll",:direction => direction.downcase, :element => element.ref)
      end

      def scroll_to_text(text)
        @driver.scroll_to(text)
      end

      def scroll_to_exact_text(text)
        @driver.scroll_to_exact(text)
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

    end
  end
end
