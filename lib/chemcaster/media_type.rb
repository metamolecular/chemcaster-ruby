module Chemcaster
  class MediaType  
    def self.representation name
      puts name
      name.match(/application\/vnd\.com\.chemcaster\.(.*)\+json/)
      raise "No such media type: #{name}" unless klass = $1
      
      begin
        Object.const_get(klass)
      rescue
        raise "No such class: #{klass}"
      end
    end
  end
end
