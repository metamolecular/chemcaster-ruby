require 'chemcaster/representation'

module Chemcaster
  class Index < Representation
    attr_accessor :item_links, :items
    resources :parent
    
    def create representation
      @create_link.post representation
    end
    
    protected
    
    def load_hash atts
      super

      @create_link = Link.new atts['create']
      @item_links = atts['items'].inject([]) do |result, atts|
        result << Link.new(atts)
      end
      @items = ItemProxy.new @item_links
    end
  end
  
  class ItemProxy
    def initialize item_links
      @item_links = item_links
    end
    
    def [](index)
      @item_links[index].get
    end
  end
end
