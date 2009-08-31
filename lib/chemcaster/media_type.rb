module Chemcaster
  class MediaType  
    def self.representation name
      name.match(/application\/vnd\.com\.chemcaster\.(.*)\+json/)
      raise "No such media type: #{name}" unless klass = $1
      
      begin
        Chemcaster.const_get("#{klass}")
      rescue
        raise "Unable to create class from media type: #{name}"
      end
    end
    
    def self.hash_key full_mime_type_name
      full_mime_type_name.match(/application\/vnd\.com\.chemcaster\.(.*)\+json/)
      raise "No such media type: #{full_mime_type_name}" unless key = $1
      
      begin
        Chemcaster.const_get(key)
      rescue
        raise "No such class: #{key}"
      end
      
      key.downcase
    end
  end
end
