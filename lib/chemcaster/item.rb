require 'chemcaster/representation'

module Chemcaster
  class Item < Representation
    def initialize hash
      super
    end  
    
    def index
      @index_link.get
    end
    
    def update representation
      @update_link.put representation
    end
    
    def destroy
      @destroy_link.delete
    end
    
    def self.attributes *atts
      atts.each do |m|
        define_method(m) do
          attributes[m.to_s]
        end        

        define_method("#{m}=") do |val|
          attributes.merge!({m.to_s => val})
        end
      end
    end
    
    def self.resources *resource_ids
      resource_ids.each do |id|
        @@resource_ids << id
        define_method(id) do  
          instance_variable_get("@#{id}_link").send('get')
        end
      end
    end
    
    protected
    
    def load_hash hash
      super
      
      ['index', 'update', 'destroy'].each do |action|
        instance_variable_set("@#{action}_link".to_sym, Link.new(hash[action]))
      end
      
      name = self.class.to_s.gsub(/Chemcaster::/, '').downcase
      attributes.merge!(hash[name]) if hash[name]
      
      @@resource_ids.each do |resource|
        instance_variable_set("@#{resource}_link".to_sym, Link.new(hash[resource.to_s]))
      end
    end
  end
end
