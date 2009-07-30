module Chemcaster
  class Index
    attr_accessor :create
    
    def initialize link
      @link = link
    end
    
    def load
      @atts = @link.get
      @create = Link.new(@atts['create'])
    end
  end
end
