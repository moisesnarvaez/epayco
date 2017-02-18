require 'faraday'
require File.expand_path('../version', __FILE__)

module EPayCo
  # Defines constants and methods related to configuration
  module Configuration
    # An array of valid keys in the options hash when configuring a {EPayCo::API}
    VALID_OPTIONS_KEYS = [
      :public_key,
      :private_key,
      :adapter,
      :connection_options,
      :endpoint,
      :format,
      :proxy,
      :user_agent
    ].freeze

    # By default, don't set a user public key
    DEFAULT_PUBLIC_KEY = nil

    # By default, don't set a user private key
    DEFAULT_PRIVATE_KEY = nil

    # The adapter that will be used to connect if none is set
    #
    # @note The default faraday adapter is Net::HTTP.
    DEFAULT_ADAPTER = Faraday.default_adapter

    # By default, don't set any connection options
    DEFAULT_CONNECTION_OPTIONS = {}

    # The endpoint that will be used to connect if none is set
    #
    # @note There is no reason to use any other endpoint at this time
    DEFAULT_ENDPOINT = 'https://api.secure.payco.co/'.freeze

    # The response format appended to the path and sent in the 'Accept' header if none is set
    #
    # @note JSON is the only available format at this time
    DEFAULT_FORMAT = :json

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "EPayCo Ruby Gem #{EPayCo::VERSION}".freeze

    # An array of valid request/response formats
    #
    # @note Not all methods support the XML format.
    VALID_FORMATS = [
      :json].freeze

    # @private
    attr_accessor *VALID_OPTIONS_KEYS

    # When this module is extended, set all configuration options to their default values
    def self.extended(base)
      base.reset
    end

    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
    end

    # Create a hash of options and their values
    def options
      VALID_OPTIONS_KEYS.inject({}) do |option, key|
        option.merge!(key => send(key))
      end
    end

    # Reset all configuration options to defaults
    def reset
      self.public_key       = DEFAULT_PUBLIC_KEY
      self.private_key       = DEFAULT_PRIVATE_KEY
      self.adapter            = DEFAULT_ADAPTER
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.endpoint           = DEFAULT_ENDPOINT
      self.format             = DEFAULT_FORMAT
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
    end
  end
end
