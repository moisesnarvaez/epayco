module EPayCo
  module Response
    def self.create( response, response_options)
      return response if response_options[:raw]
      return response.body if response_options[:no_response_wrapper]      
      return response.body[response.body.object] if response_options[:return_object] && response.body.status
      data = response.body.data.dup rescue response.body
      data.extend( self )
      data
    end
  end
end
