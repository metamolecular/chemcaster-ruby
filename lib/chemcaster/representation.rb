module Chemcaster
  class Representation
    # class instance variables - see: http://martinfowler.com/bliki/ClassInstanceVariable.html
    class << self; attr_accessor :resource_ids; end
    class << self; attr_accessor :attribute_ids; end

    attr_accessor :attributes
    attr_accessor :link
    
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
      self.resource_ids ||= self.superclass.resource_ids || []
      res.each do |id|
        self.resource_ids << id
        define_method(id) do  
          instance_variable_get("@#{id}_link").send('get')
        end
      end
    end
    
    def to_json
      JSON({attributes_name => @attributes})
    end
    
    def attributes_name
      self.class.to_s.gsub(/Chemcaster::/, '').downcase
    end
    
    protected
    
    def load_hash hash
      self.class.attribute_ids ||= []
      if hash[name = attributes_name]
        hash[name].each do |attribute|
          if self.class.attribute_ids.member? attribute[0]
            attributes[attribute[0]] = attribute[1]
          end
        end
      end

      self.class.resource_ids ||= []
      self.class.resource_ids.each do |resource_id|
        resource_data = hash[resource_id.to_s]
        if resource_data.nil?
          instance_variable_set("@#{resource_id}_link".to_sym, Link.new(hash[resource_id.to_s]))
        elsif resource_data.respond_to?(:has_key?) && resource_data['uri'] && resource_data['media_type']
          instance_variable_set("@#{resource_id}_link".to_sym, Link.new(hash[resource_id.to_s]))
        end
      end
    end
  end
end
