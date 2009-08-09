require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Representation do  
  before(:each) do
    @resource_link_template = {
      'name' => 'resource',
      'uri' => 'http://example.com'  
    }
    @hash = {
      'resource' => @resource_link_template
    }
    @resource_link = mock(Link)
    Link.stub!(:new).and_return @resource_link
    @rep=Representation.new(mock(Link), @hash)
  end
  
  it "has the correct resource link" do
    @rep.resource_link.should == @resource_link
  end
end
