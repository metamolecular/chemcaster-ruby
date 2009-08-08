require 'chemcaster/representation'

module Chemcaster
  class Item < Representation    
    def index
      @index_link.get
    end
    
    def update representation
      @update_link.put representation
    end
    
    def destroy
      @destroy_link.delete
    end
    
    protected
    
    def load_hash hash
      super
      
      ['index', 'update', 'destroy'].each do |action|
        instance_variable_set("@#{action}_link".to_sym, Link.new(hash[action]))
      end
    end
  end
end
