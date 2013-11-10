module RCone
  
  class Cone
    
    GET = 'get'
    SET = 'set'
    
    def initialize fields, params, required=[]
      @rb_field_names = fields
      @rb_fields = {}
      
      fetch_parameters fields, required, params
    end
    
    def method_missing method, *arguments
      reg_exp = /^(get|set)_(\w*)/
      match_data = method.to_s.scan reg_exp
      
      raise UndefinedMethodException unless match_data.size > 0
      raise UndefinedFieldException unless @rb_fields.has_key? match_data[0][1].to_sym
      
      handle_operation match_data[0][0], match_data[0][1], arguments[0] || nil   
    end
    
    private
        
    def handle_operation operation, field, value
      case operation
        when GET then get_value field
        when SET then set_value field, value
      end
    end
    
    def get_value field
      @rb_fields[field.to_sym]  
    end
    
    def set_value field, value
      @rb_fields[field.to_sym] = value
    end
    
    def fetch_parameters fields, required, params
      fields.each do |field|
        value = params[field]
        check_required field, value, required
        @rb_fields[field] = value
      end
    end
    
    def check_required field, value, required
      if required.include?(field) && value.nil?
        raise RCone::MissingParameterException.new "Parameter #{field} is undefined!"
      end
    end
    
  end  
  
  class MissingParameterException < Exception
  end
  
  class UndefinedFieldException < Exception
  end
  
  class UndefinedMethodException < Exception
  end
  
end