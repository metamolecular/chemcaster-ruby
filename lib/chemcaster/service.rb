require 'chemcaster/representation'

module Chemcaster
  class Service < Representation
    attr_accessor :registries_link
    
    def registries
      @registries_link.get
    end
    
    protected
    
    def load_hash hash
      super
      @registries_link = Link.new hash['registries']
    end
  end
end