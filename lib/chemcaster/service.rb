require File.dirname(__FILE__) + '/../chemcaster/representation'

module Chemcaster
  class Service < Representation
    attributes :version
    resources :registries
    
    # Ruby SSL needs to be told the location of the system's SSL CA files.
    # On Debian Linux systems, these files are located at /etc/ssl/certs,
    # which is this library's default. For more information, see:
    # 
    # http://codeidol.com/other/rubyckbk/Internet-Services/Making-an-HTTPS-Web-Request
    # http://redcorundum.blogspot.com/2008/03/ssl-certificates-and-nethttps.html
    # http://notetoself.vrensk.com/2008/09/verified-https-in-ruby
    
    @@root_ca = nil; def self.root_ca; @@root_ca; end
    @@username = nil; def self.username; @@username; end
    @@password = nil; def self.password; @@password; end
    
    def self.connect username, password, options = {}
      @@username = username; @@password = password
      
      @@root_ca = options[:root_ca] || '/etc/ssl/certs'
      uri = options[:uri] || 'https://chemcaster.com/rest'
      
      service_link = Link.new 'uri' => uri,
        'media_type' => 'application/vnd.com.chemcaster.Service+json', 'name' => 'root'
      service_link.get
    end
  end
end