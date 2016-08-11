require_relative '../spec_helper'

describe "Interface" do

  locator = "name~dummy"
  let(:selenium_driver) {double('')}
  let(:text) {ScreenObject::AppElements::TextField.new(locator)}


  context "interaction with clear method" do
    it "should clear the text field." do
      expect(text).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:text).and_return("text")
      expect(text.text).to eq "text"

    end

  end

  context "interaction with clear method" do
    it "should clear the text field." do
      expect(text).to receive(:dynamic_xpath).with("dynamic_text").and_return(selenium_driver)
      expect(selenium_driver).to receive(:displayed?).and_return(selenium_driver).and_return(true)
      expect(text.dynamic_text_exists?("dynamic_text")).to eq true
    end

  end

end
