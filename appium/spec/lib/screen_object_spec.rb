require_relative '../spec_helper'
require 'selenium-webdriver'

class TestScreen
  include ScreenObject
end

describe ScreenObject do

  let(:the_screen) { TestScreen.new }

  context 'when waiting for something to happen' do

    let(:wait) { double('wait') }

    before do
      allow(wait).to receive(:until)
    end

    it 'should wait for 5 seconds by default' do
      expect(Selenium::WebDriver::Wait).to receive(:new).with(timeout: 5, message: nil).and_return(wait)
      the_screen.wait_until { }
    end

    it 'should allow you to override the default wait time' do
      expect(Selenium::WebDriver::Wait).to receive(:new).with(timeout: 10, message: nil).and_return(wait)
      the_screen.wait_until(10) { }
    end

    it 'should allow you to provide a message to use when wait fails' do
      expect(Selenium::WebDriver::Wait).to receive(:new).with(timeout: 10, message: 'foobar').and_return(wait)
      the_screen.wait_until(10, 'foobar') { }
    end
  end
  
end

