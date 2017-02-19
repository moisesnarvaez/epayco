require File.expand_path('../spec_helper', __FILE__)

describe EPayCo do
  after do
    EPayCo.reset
  end

  describe ".client" do
    it "should be a EPayCo::Client" do
      EPayCo.client.should be_a EPayCo::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      EPayCo.adapter.should == EPayCo::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      EPayCo.adapter = :typhoeus
      EPayCo.adapter.should == :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      EPayCo.endpoint.should == EPayCo::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      EPayCo.endpoint = 'http://tumblr.com'
      EPayCo.endpoint.should == 'http://tumblr.com'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      EPayCo.user_agent.should == EPayCo::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      EPayCo.user_agent = 'Custom User Agent'
      EPayCo.user_agent.should == 'Custom User Agent'
    end
  end

  describe ".configure" do

    EPayCo::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        EPayCo.configure do |config|
          config.send("#{key}=", key)
          EPayCo.send(key).should == key
        end
      end
    end
  end
end
