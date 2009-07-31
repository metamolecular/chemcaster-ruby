require 'chemcaster/representation'

module Chemcaster
  class Item < Representation    
    def index
      raise LinkNotDefined.new("link 'index' not defined by server") unless @index
      @index.get
    end
    
    def update representation
      raise LinkNotDefined.new("link 'update' not defined by server") unless @update
      @update.put representation
    end
    
    def destroy
      raise LinkNotDefined.new("link 'destroy' not defined by server") unless @destroy
      @destroy.delete
    end
    
    protected
    
    def load_hash hash
      super
      
      ['index', 'update', 'destroy'].each do |action|
        instance_variable_set("@#{action}".to_sym, Link.new(hash[action])) if hash[action]
      end
    end
  end
end
