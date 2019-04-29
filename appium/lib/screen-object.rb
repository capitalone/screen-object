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

require 'appium_lib'
require 'screen-object/load_appium'
require 'screen-object/accessors'
require 'screen-object/elements'
require 'screen-object/screen_factory'
require 'screen-object/accessors/element'

# this module adds screen object when included.
# This module will add instance methods and screen object that you use to define and interact with mobile objects

module ScreenObject
  def self.included(cls)
    cls.extend ScreenObject::Accessors
  end

  def driver
    ScreenObject::AppElements::Element.new('').driver
  end

  def landscape
    driver.driver.rotate :landscape
  end

  def portrait
    driver.driver.rotate :portrait
  end

  def back
    driver.back
  end

  def wait_until(timeout = 5, message = nil, &block)
    driver.no_wait
    wait = Selenium::WebDriver::Wait.new(timeout: timeout, message: message)
    wait.until &block
    driver.set_wait
  end

  def wait_step(timeout = 5, message = nil, &block)
    default_wait = driver.default_wait
    wait = Selenium::WebDriver::Wait.new(timeout: driver.set_wait(timeout), message: message)
    wait.until &block
    driver.set_wait(default_wait)
  end

  def enter
    driver.send_keys(:enter)
  end

  def gesture(arg)
    Appium::TouchAction.new(driver).swipe(start_x: arg[0], start_y: arg[1], end_x: arg[2], end_y: arg[3], duration: arg[4]).perform
  rescue RuntimeError => e
    raise("Error during gesture \n Error Details: #{e}")
  end

  def scroll(direction = :down, duration = 1000)
    size = driver.window_size
    x = size.width / 2
    y = size.height / 2
    loc = case direction
          when :up then    [x, y * 0.5, x, (y + (y * 0.5)), duration]
          when :down then  [x, y, x, y * 0.5, duration]
          when :left then  [x * 0.6, y, x * 0.3, y, duration]
          when :right then [x * 0.3, y, x * 0.6, y, duration]
          else
            raise('Only upwards, downwards, leftwards and rightwards scrolling are supported')
          end
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

  def swipe_element(locator, direction = :down, duration = 1000)
    my_element = driver.find_element(locator.locator.first, locator.locator.last).rect
    start_x = my_element.x
    end_x = my_element.x + my_element.width
    start_y = my_element.y
    end_y = my_element.y + my_element.height
    height = my_element.height
    loc = case direction
          when :up then [end_x * 0.5, (start_y + (height * 0.2)), end_x * 0.5, (end_y - (height * 0.2)), duration]
          when :down then  [end_x * 0.5, (end_y - (height * 0.2)), start_x * 0.5, (start_y + (height * 0.3)), duration]
          when :left then  [end_x * 0.9,  end_y - (height / 2), start_x, end_y - (height / 2), duration]
          when :right then [end_x * 0.1, end_y - (height / 2), end_x * 0.9, end_y - (height / 2), duration]
          else
            raise('Only upwards, downwards, leftwards and rightwards scrolling are supported')
          end
    gesture(loc)
  end

  def scroll_down_to_text(text, direction = 'down')
    if driver.device_is_ios?
      driver.scroll(direction: direction.to_s, name: text.to_s)
    else
      scroll_find(text:text.to_s)
    end
  end

  def scroll_find_element(locator, direction = :down, timeout = 40)
    wait_until(timeout,'Unable to find element',&->{scroll_to_element(locator, direction)})
    driver.find_element(":#{locator.locator[0]}", locator.locator[1])
  end

  def scroll_find_text(text, direction = :down, timeout = 40)
    wait_until(timeout,'Unable to find element',&->{scroll_to_text(text, direction)})
    driver.find(text)
  end

  def scroll_click(locator={}, direction = :down, timeout = 30)
    wait_until(timeout,'Unable to find element',&->{_scroll_to(locator, direction)})
    driver.find_element(":#{locator.locator[0]}", locator.locator[1]).click
  end

  def drag_and_drop_element(source_locator, source_locator_value, target_locator, target_locator_value)
    l_draggable = driver.find_element(source_locator, source_locator_value)
    l_droppable = driver.find_element(target_locator, target_locator_value)
    obj1 = Appium::TouchAction.new
    obj1.long_press(x: l_draggable.location.x, y: l_draggable.location.y).move_to(x: l_droppable.location.x, y: l_droppable.location.y).release.perform
  end

  def keyboard_hide
    driver.hide_keyboard
  rescue StandardError
    false
  end

  # Scrolls in a direction until a string that matches is found,
  #
  # @param text      [String] The text you are looking for on the screen
  # @param direction [symbol] The direction to search for an string
  # @param tries     [Integer] The amount of times we want to scroll to find the element
  # @return          [Boolean]


  def scroll_to_text(text, direction = :down, timeout = 30)
    wait_until(timeout,'Unable to find element',&->{text_visible?(text, direction)})
  end

  def text_visible?(text, direction = :down)
    driver.find(text).displayed?
  rescue Selenium::WebDriver::Error::NoSuchElementError
    scroll(direction)
    false
  end

  # Scrolls in a direction until an element that matches is found,  or return false
  #
  # @param element   [Element] The text you are looking for on the screen
  # @param direction [symbol] The direction to search for an string
  # @param tries     [Integer] The amount of times we want to scroll to find the element
  # @return          [Boolean]

  def scroll_to_element(element, direction = :down, timeout = 30)
    wait_until(timeout,'Unable to find element',&->{element_visible?(element, direction)})
  end

  def element_visible?(element, direction = :down)
    driver.find_element("#{element.locator[0]}", "#{element.locator[1]}").displayed?
  rescue Selenium::WebDriver::Error::NoSuchElementError
    scroll(direction)
    false
  end
end
