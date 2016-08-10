require 'spec_helper'
require 'screen-object/appium_server'

describe ScreenObject::AppiumServer do

  attr_reader :the_server

  before(:each) do
    @process = double(:process)
    allow(ChildProcess).to receive(:build).and_return(@process)
    allow(@process).to receive(:start)
  end

  def the_server(params = {})
    @the_server ||= ScreenObject::AppiumServer.new(params)
  end

  def expected_build_params(*params)
    expect(ChildProcess).to receive(:build).with(*params).and_return(@process)
  end

  context "when starting the appium server" do
    it 'should start the appium process with no parameters' do
      expected_build_params('appium')
      the_server.start
    end

    it 'should pass a parameter and value to the appium process' do
      expected_build_params('appium', '--foo', 'bar')
      the_server('foo' => 'bar').start
    end

    it 'should not contain value in the server start parameter if value is nil' do
      expected_build_params('appium', '--foo')
      the_server('foo' => nil).start
    end

    it 'should accept symbol as key for the parameter' do
      expected_build_params('appium', '--foo', 'bar')
      the_server(:foo => 'bar').start
    end

    it 'should start the server process' do
      expected_build_params('appium')
      expect(@process).to receive(:start)
      the_server.start
    end
  end

  context "When stopping the appium server" do
    it 'should stop the appium process' do
      the_server.start
      expect(@process).to receive(:stop)
      the_server.stop
    end
  end

end
