require 'openssl'
require 'base64'

module EPayCo
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, params={}, response_options={})
      request(:get, path, params, response_options)
    end

    # Perform an HTTP POST request
    def post(path, params={}, response_options={})
      request(:post, path, params, response_options)
    end

    # Perform an HTTP PUT request
    def put(path, params={}, response_options={})
      request(:put, path, params, response_options)
    end

    # Perform an HTTP DELETE request
    def delete(path, params={}, response_options={})
      request(:delete, path, params, response_options)
    end

    private

    # Perform an HTTP request
    def request(method, path, params, response_options)
      response = connection(response_options[:raw]).send(method) do |request|
        case method
        when :get, :delete
          request.url(URI.encode(path), params)
        when :post, :put
          request.path = URI.encode(path)
          request.body = params.to_json unless params.empty?
        end
      end
      
      return Response.create( response, response_options )
    end
  end
end
