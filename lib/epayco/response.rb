module EPayCo
  module Response
    def self.create( response, response_options)
      return response if response_options[:raw]
      return response.body if response_options[:no_response_wrapper]      
      data = response.body.data.dup rescue response.body
      data.extend( self )
      return data[data.object] if response_options[:return_object] && data.status
      data
    end
  end
end
