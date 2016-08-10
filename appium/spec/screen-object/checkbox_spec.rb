require_relative '../spec_helper'

describe "Interface" do

  locator = "name~dummy"
  let(:selenium_object) { double('') }
  let(:check_box) {ScreenObject::AppElements::CheckBox.new(locator)}

  context "interaction with checked method" do
    it "should retun true if checked?" do
      expect(check_box).to receive(:element).and_return(selenium_object)
      expect(selenium_object).to receive(:attribute).with('checked').and_return('true')
      expect(check_box.checked?).to eq(true)
    end
  end

  context "interaction with check method" do
    it "should check the element" do
      expect(check_box).to receive(:element).and_return(selenium_object)
      expect(selenium_object).to receive(:click).and_return(true)
      expect(check_box).to receive(:checked?).and_return(false)
      expect(check_box.check).to eq(true)
    end
  end

  context "interaction with uncheck method" do
    it "should uncheck the element" do
      expect(check_box).to receive(:element).and_return(selenium_object)
      expect(selenium_object).to receive(:click).and_return(true)
      expect(check_box).to receive(:checked?).and_return(true)
      expect(check_box.uncheck).to eq(true)
    end
  end



end
