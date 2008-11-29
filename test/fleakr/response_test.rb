require File.dirname(__FILE__) + '/../test_helper'

module Fleakr
  class ResponseTest < Test::Unit::TestCase

    describe "An instance of Response" do

      it "should provide the response body as an Hpricot element" do
        response_xml = '<xml>'
        hpricot_stub = stub()

        Hpricot.expects(:XML).with(response_xml).returns(hpricot_stub)
        
        response = Response.new(response_xml)
        response.body.should == hpricot_stub
      end
      
      it "should memoize the Hpricot document" do
        response = Response.new('<xml>')
        
        Hpricot.expects(:XML).with(kind_of(String)).once.returns(stub())
        
        2.times { response.body }
      end
      
      it "should know if there are errors in the response" do
        response_xml = "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n<rsp stat=\"fail\">\n\t<err code=\"1\" msg=\"User not found\" />\n</rsp>\n"
        response = Response.new(response_xml)
        
        response.error?.should be(true)
      end

    end

  end
end