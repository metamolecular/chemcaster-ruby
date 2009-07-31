module Chemcaster
  class Service
    def self.connect uri, media_type, options = {}
      Login.login options[:user], options[:password]
      Link.new 'uri' => uri,
        'media_type' => media_type, 'name' => 'root'
    end
  end
end