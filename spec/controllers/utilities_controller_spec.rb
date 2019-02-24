require 'spec_helper'

RSpec.describe UtilitiesController, type: :controller do
  let(:response_body) { JSON.parse(response.body) }

  describe '#index' do
    before { get '/' }

    it { expect(response.status).to eq 200 }
  end

  describe '#ip' do
    before { get '/v1/ip' }

    it { expect(response.status).to eq 200 }
  end

  describe '#whoami' do
    before { get '/v1/whoami' }

    it { expect(response.status).to eq 200 }
  end

  describe '#time' do
    before { get '/v1/time' }

    it { expect(response.status).to eq 200 }
  end
end
