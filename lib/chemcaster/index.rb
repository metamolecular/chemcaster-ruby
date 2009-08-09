require 'chemcaster/representation'

module Chemcaster
  class Index < Representation
    attr_accessor :item_links
    
    def create representation
      resource_link.post representation
    end
    
    protected
    
    def load_hash atts
      super

      @item_links = atts['items'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
    end
  end
end
