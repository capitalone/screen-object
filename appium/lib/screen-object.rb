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
  attr_reader :driver

  def initialize(driver)
    @driver = driver

    has_expected_element?
  end

  def self.included(cls)
    cls.extend ScreenObject::Accessors
  end

  def swipe(start_x, start_y, end_x, end_y, touch_count, duration)
    driver.swipe(:start_x => start_x, :start_y => start_y, :end_x => end_x, :end_y => end_y, :touchCount => touch_count, :duration => duration)
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
    wait = Selenium::WebDriver::Wait.new(timeout: timeout, message: message)
    wait.until &block
  end

  def wait_step(timeout = 5, message = nil, &block)
    default_wait = driver.default_wait
    wait = Selenium::WebDriver::Wait.new(:timeout => driver.set_wait(timeout), :message => message)
    wait.until &block
    driver.set_wait(default_wait)
  end

  def enter
    #pending implementation
  end

  def scroll_down_find(locator, locator_value, num_loop = 15)
    scr = driver.window_size
    screenHeightStart = (scr.height) * 0.5
    scrollStart = screenHeightStart.to_i
    screenHeightEnd = (scr.height) * 0.2
    scrollEnd = screenHeightEnd.to_i
    for i in 0..num_loop
      begin
        if (driver.find_element(locator, locator_value).displayed?)
          break
        end
      rescue
        driver.swipe(:start_x => 0, :start_y => scrollStart, :end_x => 0, :end_y => scrollEnd, :touchCount => 2, :duration => 0)
        false
      end
    end
  end

  def scroll_down_click(locator, locator_value, num_loop = 15)
    scr = driver.window_size
    screenHeightStart = (scr.height) * 0.5
    scrollStart = screenHeightStart.to_i
    screenHeightEnd = (scr.height) * 0.2
    scrollEnd = screenHeightEnd.to_i
    for i in 0..num_loop
      begin
        if (driver.find_element(locator, locator_value).displayed?)
          driver.find_element(locator, locator_value).click
          break
        end
      rescue
        driver.swipe(:start_x => 0, :start_y => scrollStart, :end_x => 0, :end_y => scrollEnd, :touchCount => 2, :duration => 0)
        false
      end
    end
  end

  def scroll_up_find(locator, locator_value, num_loop = 15)
    scr = driver.window_size
    screenHeightStart = (scr.height) * 0.5
    scrollStart = screenHeightStart.to_i
    screenHeightEnd = (scr.height) * 0.2
    scrollEnd = screenHeightEnd.to_i
    for i in 0..num_loop
      begin
        if (driver.find_element(locator, locator_value).displayed?)
          break
        end
      rescue
        driver.swipe(:start_x => 0, :start_y => scrollEnd, :end_x => 0, :end_y => scrollStart, :touchCount => 2, :duration => 0)
        false
      end
    end
  end


  def scroll_up_click(locator, locator_value, num_loop = 15)
    scr = driver.window_size
    screenHeightStart = (scr.height) * 0.5
    scrollStart = screenHeightStart.to_i
    screenHeightEnd = (scr.height) * 0.2
    scrollEnd = screenHeightEnd.to_i
    for i in 0..num_loop
      begin
        if (driver.find_element(locator, locator_value).displayed?)
          driver.find_element(locator, locator_value).click
          break
        end
      rescue
        driver.swipe(:start_x => 0, :start_y => scrollEnd, :end_x => 0, :end_y => scrollStart, :touchCount => 2, :duration => 0)
        false
      end
    end
  end


  def drag_and_drop_element(source_locator, source_locator_value, target_locator, target_locator_value)
    l_draggable = driver.find_element(source_locator, source_locator_value)
    l_droppable = driver.find_element(target_locator, target_locator_value)
    obj1 = Appium::TouchAction.new
    obj1.long_press(:x => l_draggable.location.x, :y => l_draggable.location.y).move_to(:x => l_droppable.location.x, :y => l_droppable.location.y).release.perform
  end

  def keyboard_hide
    begin
      driver.hide_keyboard
    rescue
      false
    end
  end

end
