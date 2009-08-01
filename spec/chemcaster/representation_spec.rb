require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Representation do  
  before(:each) do
    @rep=Representation.new({})
  end
  
  describe "to_hash" do
    it "returns empty hash" do
      @rep.to_hash.should == {}
    end
  end
end
