require 'net/http'

module Chemcaster
  class Link
    def initialize atts=nil
      if atts
        @uri = URI.parse(atts['uri']) if atts['uri']
        @media_type = atts['media_type']
        @media_class = MediaType.representation(@media_type) if @media_type
      end
    end
    
    def get
      do_http 'get'
    end
    
    def put representation
      do_http 'put', representation
    end

    def post representation
      do_http 'post', representation
    end
    
    def delete
      do_http 'delete'
    end
    
    private
    
    def do_http method, representation=nil
      validate
      request = request_for_method method, representation
      response=Net::HTTP.new(@uri.host,@uri.port).start {|http| http.request(request)}
      
      raise(HTTPError, response) unless response.code.to_i < 300
      @media_class.new self, decode(response.body)
    end
    
    def request_for_method method, representation=nil
      request = case method
      when "get" then Net::HTTP::Get.new(@uri.path)
      when "put" then Net::HTTP::Put.new(@uri.path)
      when "post" then Net::HTTP::Post.new(@uri.path)
      when "delete" then Net::HTTP::Delete.new(@uri.path)
      end
      
      request['accept'] = @media_type
      request.basic_auth Login.instance.user, Login.instance.password
      
      if representation
        request.body = representation.to_json
        request.content_type = @media_type
      end
      
      request
    end
    
    def validate
      raise LinkNotDefined unless @uri && @media_class
    end
    
    def decode response
      JSON.parse response
    end
  end
end
