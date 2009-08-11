module Chemcaster
  class Error < RuntimeError; end
  class LinkNotDefined < Error; end
  class HTTPError < Error
    attr_accessor :response
    def initialize response
      @response = response
    end
    
    def to_s
      "received response code #{@response.code} with message:\n\n#{parse_errors}"
    end
    
    protected
    
    def parse_errors
      errors = nil
      message = ""
      begin
        errors = JSON.parse response.body
      rescue
        return response.body
      end
      
      errors.each do |error|
        if error['field']
          message << "- field '#{error['field']}' #{error['text']}\n"
        else
          message << "- #{error['text']}\n"
        end
      end
      
      message
    end
  end
end
