require 'chemcaster/representation'

module Chemcaster
  class Service < Representation
    attr_accessor :registries_link
    
    def registries
      raise LinkNotDefined.new("link 'index' not defined by server") unless @registries_link
      @registries_link.get
    end
    
    protected
    
    def load_hash hash
      super
      @registries_link = Link.new hash['registries']
    end
  end
end