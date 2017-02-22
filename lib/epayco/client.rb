require File.expand_path('../api', __FILE__)

module EPayCo
  # Wrapper for the EPayCo REST API
  #
  # @note All methods have been separated into modules
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include EPayCo::Client::Plans
    include EPayCo::Client::Subscription
    include EPayCo::Client::Customer
  end
end
