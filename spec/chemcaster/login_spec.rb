require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Login do
  describe "after login" do
    before(:each) do
      @user = 'user@example.com'
      @pass = 'secret'
      Login.login @user, @pass
    end
    
    describe "instance" do
      it "has username and password" do
        Login.instance.user.should == @user
        Login.instance.password.should == @pass
      end
    end
  end
end
