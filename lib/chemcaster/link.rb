module Chemcaster
  class Link
    def initialize atts={}
      @client = RestClient::Resource.new atts['uri'],
        :user => Login.instance.user || '', :password => Login.instance.password || ''
      @media_class = MediaType.representation atts['media_type']
      @media_type = atts['media_type']
    end
    
    def get
      response = decode @client.get(:accept => @media_type)
      puts response
      @media_class.new response
    end
    
    def put representation
      response = decode @client.put(encode(representation),
        :accept => @media_type, :content_type => @media_type)
      @media_class.new response
    end
    
    def post representation
      response = decode @client.post(encode(representation),
        :accept => @media_type, :content_type => @media_type)
      @media_class.new response
    end
    
    def delete
      response = decode @client.delete(:accept => @media__type)
      @media_class.new response
    end
    
    private
    
    def decode response
      JSON.parse response
    end
    
    def encode representation
      name = representation.class.to_s.gsub(/Chemcaster::/, '').downcase
      JSON(name => representation.to_hash)
    end
  end
end
