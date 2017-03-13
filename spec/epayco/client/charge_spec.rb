require File.expand_path('../../../spec_helper', __FILE__)

describe EPayCo::Client do
  let(:public_key){ '1111111aaa11111111' }
  let(:private_key){ '2222222bbb22222222' }
  let(:client) { EPayCo::Client.new(:public_key => public_key, :private_key => private_key) }

  # TODO: Make tests for erros
  describe ".charge_create" do    
    let(:charge_params) { {
      token_card: "hMsDAjwD7KLsgZQ54",
      customer_id: "6eba2u73ZBh49Po7q",
      plan_id: "cursocarpinteria",
      doc_type: "CC",
      doc_number: "1035851980",
      name: "John",
      last_name: "Doe",
      email: "example@email.com",
      ip: "192.198.2.114",
      bill: "OR-1234",
      description: "Test Payment",
      value: "116000",
      tax: "16000",
      tax_base: "100000",
      currency: "COP",
      dues: "12"
    } }

    before do
      stub_post("payment/v1/charge/create").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("charge_create.json"), :headers => {:content_type => "application/json;"})
      @response = client.charge_create(charge_params)
    end

    it { expect(a_post("payment/v1/charge/create")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Mash) }
    it { expect(@response.status).to eq "Creado" }
  end
end
