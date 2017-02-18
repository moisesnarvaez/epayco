require File.expand_path('../epayco/error', __FILE__)
require File.expand_path('../epayco/configuration', __FILE__)
require File.expand_path('../epayco/api', __FILE__)
require File.expand_path('../epayco/client', __FILE__)
require File.expand_path('../epayco/response', __FILE__)

module EPayCo
  extend Configuration

  class << self
    # Alias for EPayCo::Client.new
    #
    # @return [EPayCo::Client]
    def client(options={})
      EPayCo::Client.new(options)
    end

    # Delegate to EPayCo::Client
    def method_missing(method, *args, &block)
      return super unless client.respond_to?(method)
      client.send(method, *args, &block)
    end

    # Delegate to EPayCo::Client
    def respond_to?(method, include_all=false)
      return client.respond_to?(method, include_all) || super
    end
  end
end # EPayCo
