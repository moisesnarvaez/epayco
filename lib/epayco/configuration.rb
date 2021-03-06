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
      :proxy,
      :user_agent,
      :test_mode
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

    # By default, don't use a proxy server
    DEFAULT_PROXY = nil

    # The user agent that will be sent to the API endpoint if none is set
    DEFAULT_USER_AGENT = "EPayCo Ruby Gem #{EPayCo::VERSION}".freeze

    # Test param that will be send in the POST requets
    DEFAULT_TEST_MODE = false

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
      self.public_key         = DEFAULT_PUBLIC_KEY
      self.private_key        = DEFAULT_PRIVATE_KEY
      self.adapter            = DEFAULT_ADAPTER
      self.connection_options = DEFAULT_CONNECTION_OPTIONS
      self.endpoint           = DEFAULT_ENDPOINT
      self.proxy              = DEFAULT_PROXY
      self.user_agent         = DEFAULT_USER_AGENT
      self.test_mode          = DEFAULT_TEST_MODE
    end
  end
end
