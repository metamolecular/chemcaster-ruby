require 'chemcaster/representation'

module Chemcaster
  class Item < Representation
    resources :index
    
    def update representation
      @update_link.put representation
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
