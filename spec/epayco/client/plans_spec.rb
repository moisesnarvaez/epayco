require File.expand_path('../../../spec_helper', __FILE__)

describe EPayCo::Client do
  EPayCo::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        public_key  = '111111111111111'
        private_key = '222222222222222'
        @client = EPayCo::Client.new(:format => format, :public_key => public_key, :private_key => private_key)
      end

      describe ".user_search" do

        # before do
        #   stub_get("users/search.#{format}").
        #     with(:query => {:access_token => @client.access_token}).
        #     with(:query => {:q => "Shayne Sweeney"}).
        #     to_return(:body => fixture("user_search.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
        # end

        it "should return all the plans" do
          @client.plan_all
          # a_get("users/search.#{format}").
          #   with(:query => {:access_token => @client.access_token}).
          #   with(:query => {:q => "Shayne Sweeney"}).
          #   should have_been_made
        end
      end
    end
  end
end
