require_relative '../spec_helper'

describe "Interface" do
  

  locator = "name~dummy"
  let(:selenium_driver) {double('')}
  let(:text_field) {ScreenObject::AppElements::TextField.new(locator)}

  context "interaction with text=(text) method" do
    it "should enter text into text field." do
      expect(text_field).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:send_keys).with("text").and_return("text")
      expect(text_field.text = "text").to eq "text"
    end

  end

  context "interaction with text method" do
    it "should retrive text from text" do
      expect(text_field).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:text).and_return(true)
      expect(text_field.text).to be true
    end

  end

  context "interaction with clear method" do
    it "should clear the text field." do
      expect(text_field).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:clear).and_return(true)
      expect(text_field.clear).to be true
    end

  end

end
