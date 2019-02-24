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

  describe '#echo' do
    before { get '/v1/echo' }

    it { expect(response.status).to eq 200 }
  end

  describe '#status' do
    context 'given a valid HTTP status' do
      before { get '/v1/status/:status', status: '201' }

      it { expect(response.status).to eq 201 }
    end

    context 'given an invalid HTTP status' do
      before { get '/v1/status/:status', status: '599' }

      it { expect(response.status).to eq 400 }
    end
  end

  describe '#status_index' do
    before { get '/v1/status' }

    it { expect(response.status).to eq 200 }
  end
end
