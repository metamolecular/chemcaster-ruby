module Chemcaster
  class Structure < Item
    attributes :name, :molfile
    resources :images
    
#    def images
#      @images_link.get
#    end
    
    protected
    
    def load_hash hash
      super
#      @images_link = Link.new hash['images']
    end
  end
end