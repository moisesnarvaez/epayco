require File.expand_path('../../../spec_helper', __FILE__)

describe EPayCo::Client do
  let(:public_key){ '111111111111111' }
  let(:private_key){ '222222222222222' }
  let(:client) { EPayCo::Client.new(:public_key => public_key, :private_key => private_key) }

  describe ".customer_all" do
    before do
      stub_get("recurring/v1/customers/#{public_key}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'EPayCo Ruby Gem 0.0.1'}).
        to_return(:status => 200, :body => fixture("customer_all.json"), :headers => {:content_type => "application/json;"})
      @customers = client.customer_all
    end

    it { expect(a_get("recurring/v1/customers/#{public_key}")).to have_been_made }
    it { expect(@customers).to be_an(Array) }
    it { expect(@customers.size).to eq 2 }
    it { expect(@customers.first.id_customer).to eq "PKEMb9wfxQjttGeP" }
    it { expect(@customers.first.object).to eq "customer" }
  end

  describe ".customer_create" do    
    let(:customer_params) { {
      token_card: "ZdTo2WFZEH9r3HC7N",
      name: "Joe Doe",
      email: "joe@payco.co",
      phone: "3005234321",
      default: true
    } }

    before do
      stub_post("recurring/v1/customer/create").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'EPayCo Ruby Gem 0.0.1'}).
        to_return(:status => 200, :body => fixture("customer_create.json"), :headers => {:content_type => "application/json;"})
      @response = client.customer_create(customer_params)
    end

    it { expect(a_post("recurring/v1/customer/create")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Mash) }
    it { expect(@response.status).to eq "Creado" }
  end
end
