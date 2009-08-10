module Chemcaster
  class Link
    def initialize atts=nil
      if atts
        if atts['uri']
          @client = RestClient::Resource.new atts['uri'],
            :user => Login.instance.user || '', :password => Login.instance.password || ''
        end
        if @media_type = atts['media_type']
          @media_class = MediaType.representation @media_type
        end
      end
    end
    
    def get
      validate
      response = decode @client.get(:accept => @media_type)
      @media_class.new self, response
    end
    
    def put representation
      validate
      response = decode @client.put(encode(representation),
        :accept => @media_type, :content_type => @media_type)
      @media_class.new self, response
    end
    
    def post representation
      validate
      response = decode @client.post(encode(representation),
        :accept => @media_type, :content_type => @media_type)
      @media_class.new self, response
    end
    
    def delete
      validate
      response = decode @client.delete(:accept => @media_type)
      @media_class.new self, response
    end
    
    private
    
    def validate
      raise LinkNotDefined unless @client && @media_class
    end
    
    def decode response
      JSON.parse response
    end
    
    def encode representation
      name = representation.class.to_s.gsub(/Chemcaster::/, '').downcase
      JSON(name => representation.attributes)
    end
  end
end
