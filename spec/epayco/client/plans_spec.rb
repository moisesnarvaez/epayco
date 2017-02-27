require File.expand_path('../../../spec_helper', __FILE__)

describe EPayCo::Client do
  let(:public_key){ '111111111111111' }
  let(:private_key){ '222222222222222' }
  let(:client) { EPayCo::Client.new(:public_key => public_key, :private_key => private_key) }

  describe ".plan_all" do
    before do
      stub_get("recurring/v1/plans/#{public_key}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("plan_all.json"), :headers => {:content_type => "application/json;"})
      @plans = client.plan_all
    end

    it { expect(a_get("recurring/v1/plans/#{public_key}")).to have_been_made }
    it { expect(@plans).to be_an(Array) }
    it { expect(@plans.size).to eq 1 }
    it { expect(@plans.first.id_plan).to eq "test" }
  end

  describe ".plan_create" do    
    let(:plan_params) { {
      id_plan: "test", name: "Test", description: "Plan de prueba", amount: 30,
      currency: "USD", interval: "year", interval_count: 1, trial_days: 0
    } }

    before do
      stub_post("recurring/v1/plan/create").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("plan_create.json"), :headers => {:content_type => "application/json;"})
      @response = client.plan_create(plan_params)
    end

    it { expect(a_post("recurring/v1/plan/create")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Mash) }
    it { expect(@response.status).to eq "Creado" }
  end

  describe ".plan_details" do
    let(:plan_id) { "test" }
    before do
      stub_get("recurring/v1/plan/#{public_key}/#{plan_id}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("plan_details.json"), :headers => {:content_type => "application/json;"})
      @plan = client.plan_details(plan_id)
    end

    it { expect(a_get("recurring/v1/plan/#{public_key}/#{plan_id}")).to have_been_made }
    it { expect(@plan).to be_an(Hash) }
    it { expect(@plan.id_plan).to eq "test" }
  end

  describe ".plan_update" do
    let(:plan_id) { "test" }
    let(:plan_params) { {
      id_plan: "test", name: "Prueba", description: "Plan de prueba", amount: 30,
      currency: "USD", interval: "year", interval_count: 1, trial_days: 0
    } }
    before do
      stub_put("recurring/v1/plan/edit/#{public_key}/#{plan_id}").
        with(:headers => {'Accept'=>'application/json; charset=utf-8;', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>"EPayCo Ruby Gem #{EPayCo::VERSION}"}).
        to_return(:status => 200, :body => fixture("plan_update.json"), :headers => {:content_type => "application/json;"})
      @response = client.plan_update(plan_id, plan_params)
    end

    it { expect(a_put("recurring/v1/plan/edit/#{public_key}/#{plan_id}")).to have_been_made }
    it { expect(@response).to be_a(Hashie::Hash) }
    it { expect(@response.status).to eq "Actualizado" }
  end
end
