require 'chemcaster/representation'

module Chemcaster
  class Item < Representation
    resources :index
    
    def update representation
      link.put representation
    end
    
    def destroy
      link.delete
    end
  end
end
