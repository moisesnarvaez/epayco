require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module EPayCo
  # @private
  module Connection
    private

    def connection(raw=false)
      options = {
        :headers => {
          'Accept' => "application/json; charset=utf-8;",
          'Content-Type' => "application/json",
          'User-Agent' => user_agent},
        :proxy => proxy,
        :url => endpoint,
      }.merge(connection_options)

      Faraday::Connection.new(options) do |connection|
        connection.use Faraday::Request::UrlEncoded
        unless raw
          connection.use FaradayMiddleware::Mashify 
          connection.use Faraday::Response::ParseJson
        end
        connection.use FaradayMiddleware::RaiseHttpException
        connection.adapter(adapter)
      end
    end
  end
end
