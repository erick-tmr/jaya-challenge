require 'rails_helper'

RSpec.describe IssueEventParser, type: :lib do
  let(:payload) do
    {
      issue: {
        id: '452547854'
      },
      action: 'created'
    }.with_indifferent_access
  end
  let(:json_payload) { payload.to_json }
  let(:response) { described_class.call(payload: json_payload) }

  it 'returns a hash with action, issue_id and payload' do
    expect(response).to have_key(:action)
    expect(response).to have_key(:issue_id)
    expect(response).to have_key(:payload)
  end

  it 'returns the issue id from the payload' do
    expect(response[:issue_id]).to eq(payload[:issue][:id])
  end

  it 'returns the action from the payload' do
    expect(response[:action]).to eq(payload[:action])
  end

  it 'returns the entire payload' do
    payload.keys.each do |key|
      expect(response[:payload]).to have_key(key)
    end
  end
end
