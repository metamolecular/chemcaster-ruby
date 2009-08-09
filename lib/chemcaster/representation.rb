module Chemcaster
  class Representation
    # class instance variables - see: http://martinfowler.com/bliki/ClassInstanceVariable.html
    class << self; attr_accessor :resource_ids; end
    class << self; attr_accessor :attribute_ids; end

    attr_accessor :attributes
    attr_accessor :link
    attr_accessor :resource_link
    
    def initialize link, raw
      @link = link
      @attributes = {}
      load_hash raw
    end
    
    def self.attributes *atts
      self.attribute_ids ||= []
      atts.each do |m|
        self.attribute_ids << m.to_s
        define_method(m) do
          attributes[m.to_s]
        end        

        define_method("#{m}=") do |val|
          attributes.merge!({m.to_s => val})
        end
      end
    end
    
    def self.resources *res
      self.resource_ids ||= []
      res.each do |id|
        self.resource_ids << id
        define_method(id) do  
          instance_variable_get("@#{id}_link").send('get')
        end
      end
    end
    
        
    protected
    
    def load_hash hash
      if hash[name = self.class.to_s.gsub(/Chemcaster::/, '').downcase]
        hash[name].each do |attribute|
          if self.class.attribute_ids.member? attribute[0]
            attributes[attribute[0]] = attribute[1]
          end
        end
      end

      @resource_link = Link.new(hash['resource'])
      
      self.class.resource_ids ||= []
      self.class.resource_ids.each do |resource_id|
        instance_variable_set("@#{resource_id}_link".to_sym, Link.new(hash[resource_id.to_s]))
      end
    end
  end
end
