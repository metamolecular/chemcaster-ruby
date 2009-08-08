module Chemcaster
  class Site
    def self.connect uri, options = {}
      Login.login options[:user], options[:password]
      service_link = Link.new 'uri' => uri,
        'media_type' => 'application/vnd.com.chemcaster.Service+json', 'name' => 'root'
      service_link.get
    end
  end
end