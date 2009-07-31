module Chemcaster
  @@instance = nil
  
  class Login
    def self.login user, password
      @@user = user
      @@pass = password
    end
    
    def self.instance     
      @@instance ? @@instance : @@instance = Login.new
    end
    
    def user
      @@user
    end
    
    def password
      @@pass
    end
  end
end