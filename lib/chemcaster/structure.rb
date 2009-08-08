module Chemcaster
  class Structure < Item
    attr_accessor :name
    attr_accessor :molfile
    
    def images
      @images_link.get
    end
    
    def to_hash
      super.merge('molfile' => molfile, 'name' => name)
    end
    
    protected
    
    def load_hash hash
      super
      @name = hash['structure']['name'] if hash['structure']
      @molfile = hash['structure']['molfile'] if hash['structure']
      @images_link = Link.new hash['images']
    end
  end
end