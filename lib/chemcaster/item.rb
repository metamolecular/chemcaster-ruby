require 'chemcaster/representation'

module Chemcaster
  class Item < Representation
    resources :index
    
    def update representation
      resource_link.put representation
    end
    
    def destroy
      resource_link.delete
    end
  end
end
