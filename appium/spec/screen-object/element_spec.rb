require_relative '../spec_helper'

describe "Interface" do

   locator = "name~dummy"
   let(:selenium_driver) {double('')}
   let(:element) {ScreenObject::AppElements::Element.new(locator)}

  context "interaction with click method" do
    it "should click on element" do
      expect(element).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:click).and_return(true)
      expect(element.click).to be true
    end

  end

  context "interaction with value method" do
    it "should return value" do
      expect(element).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:value).and_return("value")
      expect(element.value).to eql ("value")
    end

  end

  context "interaction with exists? method" do
    it "should return value" do
      expect(element).to receive(:element).and_return(selenium_driver)
      expect(selenium_driver).to receive(:displayed?).and_return(true)
      expect(element.exists?).to eql (true)
    end

  end

   context "interaction with element method" do
     it "should return element object" do
       expect(element).to receive(:driver).and_return(selenium_driver)
       expect(selenium_driver).to receive(:find_element).and_return(selenium_driver)
       expect(element.element).to eql (selenium_driver)
     end

   end

   context "interaction with element method" do
     it "should return element object" do
       expect(element).to receive(:driver).and_return(selenium_driver)
       expect(selenium_driver).to receive(:find_elements).and_return(selenium_driver)
       expect(element.elements).to eql (selenium_driver)
     end

   end

   context "interaction with element method" do
     it "should return element object" do
       expect(element).to receive(:dynamic_xpath).and_return(selenium_driver)
       expect(selenium_driver).to receive(:displayed?).and_return(true)
       expect(element.dynamic_text_exists?("dynamic_text")).to eql (true)
     end

   end

   # context "interaction with scroll method" do
   #   it "should return element object" do
   #     expect(element).to receive(:driver).and_return(selenium_driver)
   #     expect(selenium_driver).to receive(:execute_script).and_return(selenium_driver)
   #     expect(element.scroll).to eql (selenium_driver)
   #   end
   # end

   context "interaction with scroll_for_element_click method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:displayed?).and_return(true)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.scroll_for_element_click).to eql (true)
     end

   end

   context "interaction with scroll_for_element_click method" do
     it "should scroll for element and click.." do
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:displayed?).and_return(false)
       expect(element).to receive(:scroll).and_return(selenium_driver)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.scroll_for_element_click).to eql (true)
     end

   end

   context "interaction with scroll_for_dynamic_element_click method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:dynamic_xpath).with("expected_text").and_return(selenium_driver)
       expect(selenium_driver).to receive(:displayed?).and_return(true)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.scroll_for_dynamic_element_click("expected_text")).to eql (true)
     end

   end

   context "interaction with scroll_for_dynamic_element_click method" do
     it "should scroll for element and click.." do
       expect(element).to receive(:dynamic_xpath).with("expected_text").and_return(selenium_driver)
       expect(selenium_driver).to receive(:displayed?).and_return(false)
       expect(element).to receive(:scroll).and_return(selenium_driver)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.scroll_for_dynamic_element_click("expected_text")).to eql (true)
     end

   end

   context "interaction with click_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:exists?).and_return(true)
       expect(element).to receive(:click).and_return(true)
       expect(element.click_text("text")).to eq (true)
     end

   end

   context "interaction with click_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:exists?).and_return(false)
       expect(element).to receive(:scroll_to_text).with("text").and_return(selenium_driver)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_text("text")).to eq (true)
     end

   end

   context "interaction with click_dynamic_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:dynamic_text_exists?).with("text").and_return(true)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_dynamic_text("text")).to eq (true)
     end

   end

   context "interaction with click_dynamic_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:dynamic_text_exists?).with("text").and_return(false)
       expect(element).to receive(:scroll_to_text).with("text").and_return(selenium_driver)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_dynamic_text("text")).to eq (true)
     end

   end


   context "interaction with click_exact_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:exists?).and_return(true)
       expect(element).to receive(:click).and_return(true)
       expect(element.click_exact_text("text")).to eq (true)
     end

   end

   context "interaction with click_exact_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:exists?).and_return(false)
       expect(element).to receive(:scroll_to_exact_text).with("text").and_return(selenium_driver)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_exact_text("text")).to eq (true)
     end

   end

   context "interaction with click_dynamic_exact_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:dynamic_text_exists?).with("text").and_return(true)
       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_dynamic_exact_text("text")).to eq (true)
     end

   end

   context "interaction with click_exact_text method" do
     it "should click on object if it does exists on the first page" do
       expect(element).to receive(:dynamic_text_exists?).with("text").and_return(false)
       expect(element).to receive(:scroll_to_exact_text).with("text").and_return(selenium_driver)

       expect(element).to receive(:element).and_return(selenium_driver)
       expect(selenium_driver).to receive(:click).and_return(true)
       expect(element.click_dynamic_exact_text("text")).to eq (true)
     end

   end

end



