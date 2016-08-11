=begin
***********************************************************************************************************
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

require 'childprocess'

#
# This class is designed to start and stop the appium server process.  In order to use
# it you must have appium and node installed on your computer.  You can pass parameters
# to appium at startup via the constructor.
#
module ScreenObject
  class AppiumServer

    attr_accessor :process
    

    def initialize(params={})
      @params = params
    end

    #
    # Start the appium server
    #
    def start
      @process = ChildProcess.build(*parameters)
      process.start
    end

    #
    # Stop the appium server
    #
    def stop
      process.stop
    end

    private

    def parameters
      cmd = ['appium']
      @params.each do |key, value|
        cmd << '--'+key.to_s
        cmd << value.to_s if not value.nil? and value.size > 0
      end
      cmd
    end
  end
end
