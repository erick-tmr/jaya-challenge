require 'rails_helper'

RSpec.describe Api::Webhooks::GithubListenerController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  describe 'POST listen' do
    let(:params) do
      {
        action: 'edited',
        issue: {
          id: '45854585'
        }
      }
    end
    let(:json_body) { params.to_json }
    let(:secret_key) { Rails.application.credentials[:github][:webhook_secret] }

    before do |example|
      controller.request.headers['X-Hub-Signature'] = Security::GithubPayloadDigester.call(
        payload: json_body,
        secret_key: secret_key
      )

      next if example.metadata[:skip_before]

      post :listen, body: json_body, format: :json
    end

    it 'returns http_status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the message "Event registered."' do
      expect(json[:message]).to eq('Event registered.')
    end

    it 'creates an event', :skip_before do
      expect do
        post :listen, body: json_body, format: :json
      end.to change { Event.count }.by(1)
    end

    context 'when its not possible to save the event' do
      let(:service_mock) { class_double('EventProcessor').as_stubbed_const(transfer_nested_constants: true) }

      before do
        allow(service_mock).to receive(:call).and_return(false)

        post :listen, body: json_body, format: :json
      end

      it 'returns an error message', :skip_before do
        expect(json[:error]).to eq('Could not process event.')
      end
    end

    context 'when its not possible to validate the X-Hub-Signature header hash' do
      let(:secret_key) { 'SomethingWr0ng!' }

      it 'returns an error message' do
        expect(json[:error]).to eq('Could not recognize payload signature.')
      end
    end
  end
end
