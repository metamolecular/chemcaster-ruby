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
    
    def self.attributes *attribute_ids
      attribute_ids.each do |m|
        @@attribute_ids << m.to_s
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
      
      if hash[name = self.class.to_s.gsub(/Chemcaster::/, '').downcase]
        hash[name].each do |attribute|
          if @@attribute_ids.member? attribute[0]
            attributes[attribute[0]] = attribute[1]
          end
        end
      end
            
      ['index', 'update', 'destroy'].each do |action|
        instance_variable_set("@#{action}_link".to_sym, Link.new(hash[action]))
      end
      
      @@resource_ids.each do |resource_id|
        instance_variable_set("@#{resource_id}_link".to_sym, Link.new(hash[resource_id.to_s]))
      end
    end
  end
end
