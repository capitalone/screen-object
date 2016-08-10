require_relative '../spec_helper'

describe "Interface" do

  locator = "name~dummy"
  let(:selenium_object) { double('') }
  let(:button) {ScreenObject::AppElements::Button.new(locator)}

  context "interaction with tap method" do
    it "should tap on the button" do
      expect(button).to receive(:element).and_return(selenium_object)
      expect(selenium_object).to receive(:click).and_return(true)
      expect(button.tap).to eq(true)
    end
  end

  context "interaction with enable method" do
    it "should check if button is enabled" do
      expect(button).to receive(:element).and_return(selenium_object)
      expect(selenium_object).to receive(:enabled?).and_return(true)
      expect(button.enabled?).to eq(true)
    end
  end


end
