module Chemcaster
  class Link
    def initialize atts={}
      @client = RestClient::Resource.new atts['uri']
      @media_class = MediaType.locate atts['media_type']
    end
    
    def get
      json = JSON @client.get(:accept => @media_class.name)
      @media_class.new json
    end
  end
end
