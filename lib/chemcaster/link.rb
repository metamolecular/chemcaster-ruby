require 'net/http'
require 'net/https'

module Chemcaster  
  class Link
    attr_reader :uri, :media_type
    
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
    
    def put attributes
      do_http 'put', attributes
    end

    def post attributes
      do_http 'post', attributes
    end
    
    def delete
      do_http 'delete'
    end
    
    private
    
    def do_http method, representation=nil
      validate
      request = request_for_method method, representation
      response = send_request request

      raise(HTTPError, response) unless response.code.to_i < 300
      @media_class.new self, decode(response)
    end
    
    def send_request request
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = (@uri.scheme == 'https')
      
      if File.exists? Service.root_ca
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.ca_path = Service.root_ca
      else
        message =
          "net/http couldn't locate this system's root SSL certificate files."+
          "On Debian Linux systems, these files are located at /etc/ssl/certs "+
          "(this library's default). For more information, see:\n\n"+
          "http://codeidol.com/other/rubyckbk/Internet-Services/Making-an-HTTPS-Web-Request\n"+
          "http://redcorundum.blogspot.com/2008/03/ssl-certificates-and-nethttps.html\n"+
          "http://notetoself.vrensk.com/2008/09/verified-https-in-ruby\n"
        raise(message)
      end
      
      http.request(request)
    end
    
    def request_for_method method, attributes=nil
      request = case method
      when "get" then Net::HTTP::Get.new(@uri.path)
      when "put" then Net::HTTP::Put.new(@uri.path)
      when "post" then Net::HTTP::Post.new(@uri.path)
      when "delete" then Net::HTTP::Delete.new(@uri.path)
      end
      
      request['accept'] = @media_type
      request.basic_auth Service.username, Service.password
      
      if attributes
        request.body = {MediaType.hash_key(@media_type) => attributes}.to_json
        request.content_type = @media_type
      end
      
      request
    end
    
    def validate
      raise LinkNotDefined unless @uri && @media_class
    end
    
    def decode response
      if response.content_type.match(/application\/vnd\.com\.chemcaster\.(.*)\+json/)
        JSON.parse response.body 
      else
        response.body
      end
    end
  end
end
