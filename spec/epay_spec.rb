require File.expand_path('../spec_helper', __FILE__)

describe EPayCo do
  after do
    EPayCo.reset
  end

  describe ".client" do
    it "should be a EPayCo::Client" do
      expect(EPayCo.client).to be_a EPayCo::Client
    end
  end

  describe ".adapter" do
    it "should return the default adapter" do
      expect(EPayCo.adapter).to eq EPayCo::Configuration::DEFAULT_ADAPTER
    end
  end

  describe ".adapter=" do
    it "should set the adapter" do
      EPayCo.adapter = :typhoeus
      expect(EPayCo.adapter).to eq :typhoeus
    end
  end

  describe ".endpoint" do
    it "should return the default endpoint" do
      expect(EPayCo.endpoint).to eq EPayCo::Configuration::DEFAULT_ENDPOINT
    end
  end

  describe ".endpoint=" do
    it "should set the endpoint" do
      EPayCo.endpoint = 'http://tumblr.com'
      expect(EPayCo.endpoint).to eq 'http://tumblr.com'
    end
  end

  describe ".user_agent" do
    it "should return the default user agent" do
      expect(EPayCo.user_agent).to eq EPayCo::Configuration::DEFAULT_USER_AGENT
    end
  end

  describe ".user_agent=" do
    it "should set the user_agent" do
      EPayCo.user_agent = 'Custom User Agent'
      expect(EPayCo.user_agent).to eq 'Custom User Agent'
    end
  end

  describe ".configure" do

    EPayCo::Configuration::VALID_OPTIONS_KEYS.each do |key|

      it "should set the #{key}" do
        EPayCo.configure do |config|
          config.send("#{key}=", key)
          expect(EPayCo.send(key)).to eq key
        end
      end
    end
  end
end
