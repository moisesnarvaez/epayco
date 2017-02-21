module EPayCo
  module Response
    def self.create( response, response_options)
      return response if response_options[:raw]
      return response.body if response_options[:no_response_wrapper]      
      if response_options[:return_object] && response.body.status
        object_key = response_options[:return_object].is_a?(String) ? response_options[:return_object] : response.body.object
        return response.body[object_key]
      end
      info = response.body.dup
      info.extend( self )
      info
    end
  end
end
