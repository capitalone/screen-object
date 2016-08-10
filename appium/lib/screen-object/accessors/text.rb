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


module ScreenObject
  module AppElements
    class Text < AppElements::Element

      def text
        element.text()
      end

      def click
        element.click
      end

      def dynamic_text_exists? dynamic_text
         begin
          dynamic_xpath(dynamic_text).displayed?
        rescue
          false
        end
      end

      def dynamic_text dynamic_text
        begin
          dynamic_xpath(dynamic_text).displayed?
          text
        rescue
          false
        end
      end

    end
  end
end
