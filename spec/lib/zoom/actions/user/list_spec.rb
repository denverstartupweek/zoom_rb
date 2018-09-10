# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do

  before :all do
    @zc = zoom_client
  end

  describe '#user_list action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/user/list')
      ).to_return(body: json_response('user', 'list'))
    end

    it 'returns a hash' do
      expect(@zc.user_list).to be_kind_of(Hash)
    end

    it "returns 'total_records" do
      expect(@zc.user_list['total_records']).to eq(235)
    end

    it "returns 'users' Array" do
      expect(@zc.user_list['users']).to be_kind_of(Array)
    end
  end

  describe '#user_list! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/user/list')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        @zc.user_list!
      }.to raise_error(Zoom::Error)
    end
  end
end
