require File.expand_path('../../../spec_helper', __FILE__)

describe EPayCo::Client do
  let(:public_key){ '111111111111111' }
  let(:private_key){ '222222222222222' }
  let(:client) { EPayCo::Client.new(:public_key => public_key, :private_key => private_key) }

  describe ".subscription_all" do
    before do
      stub_get("recurring/v1/subscriptions/#{public_key}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("subscription_all.json"), :headers => {:content_type => "application/json;"})
      @subscriptions = client.subscription_all
    end

    it { expect(a_get("recurring/v1/subscriptions/#{public_key}")).to have_been_made }
    it { expect(@subscriptions).to be_an(Array) }
    it { expect(@subscriptions.size).to eq 2 }
    it { expect(@subscriptions.first._id).to eq "wAzyX9Sutm3BaLxM2" }
  end

  describe ".subscription_create" do    
    let(:subscription_params) { {
      id_plan: "cursocarpinteria",
      customer: "6eba2u73ZBh49Po7q",
      token_card: "ZdTo2WFZEH9r3HC7N"
    } }

    before do
      stub_post("recurring/v1/subscription/create").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("subscription_create.json"), :headers => {:content_type => "application/json;"})
      @response = client.subscription_create(subscription_params)
    end

    it { expect(a_post("recurring/v1/subscription/create")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Mash) }
    it { expect(@response.id).to eq "wAzyX9Sutm3BaLxM2" }
  end

  describe ".subscription_details" do
    let(:subscription_id) { "test" }
    before do
      stub_get("recurring/v1/subscription/#{subscription_id}/#{public_key}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("subscription_create.json"), :headers => {:content_type => "application/json;"})
      @subscription = client.subscription_details(subscription_id)
    end

    it { expect(a_get("recurring/v1/subscription/#{subscription_id}/#{public_key}")).to have_been_made }
    it { expect(@subscription).to be_an(Hash) }
    it { expect(@subscription.id).to eq "wAzyX9Sutm3BaLxM2" }
  end

  describe ".subscription_cancel" do
    let(:subscription_id) { "test" }
    before do
      stub_post("recurring/v1/subscription/cancel").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("subscription_cancel.json"), :headers => {:content_type => "application/json;"})
      @response = client.subscription_cancel(subscription_id)
    end

    it { expect(a_post("recurring/v1/subscription/cancel")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Hash) }
    it { expect(@response.status).to eq "Actualizado" }
  end
end
