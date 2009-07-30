module Chemcaster
  class Link
    def initialize atts={}
      @client = RestClient::Resource.new atts['uri']
      @media_type = MediaType.locate atts['media_type']
    end
    
    def get
      @media_type.representation(@client.get(:accept => @media_type.name))
    end
  end
end
