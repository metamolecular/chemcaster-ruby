require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe MediaType do
  describe "representation" do
    def do_representation
      @registry = MediaType.representation @media_type
    end
    
    describe "with application/vnd.com.chemcaster.Registry+json" do
      before(:each) do
        @media_type = "application/vnd.com.chemcaster.Registry+json"
      end
      
      it "returns a Registry" do
        do_representation.should == Registry
      end
    end
    
    describe "with application/foo.bar.Foo+json" do
      before(:each) do
        @media_type = "application/foo.bar.Foo+json"
      end
      
      it "raises" do
        lambda{do_representation}.should raise_error
      end
    end
  end
end