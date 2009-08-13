require File.dirname(__FILE__) + '/../chemcaster/representation'

module Chemcaster
  class Item < Representation
    resources :index
    
    def update representation_attributes
      @update_link.put representation_attributes
    end
    
    def destroy
      @destroy_link.delete
    end
    
    protected
    
    def load_hash atts
      super
      
      @update_link = Link.new atts['update']
      @destroy_link = Link.new atts['destroy']
    end
  end
end
