require 'chemcaster/item'

module Chemcaster
  class Registry < Item
    attributes :name
    resources :queries, :structures
#    
#    def structures
#      @structures_link.get
#    end
#    
#    def queries
#      @queries_link.get
#    end
    
    protected
    
    def load_hash hash
      super
#      @structures_link = Link.new hash['structures']
#      @queries_link = Link.new hash['queries']
    end
  end
end