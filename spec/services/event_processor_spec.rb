require 'rails_helper'

RSpec.describe EventProcessor, type: :lib do
  let(:issue_id) { '12312231223' }
  let(:params) do
    {
      issue_id: issue_id,
      action: 'edited',
      payload: {
        'some' => 'content'
      }
    }
  end
  let(:response) { described_class.call(params: params) }

  it 'returns a bool idicating whether the operation was successfull or not' do
    expect(response).to eq(true)
  end

  it 'creates an issue' do
    expect { response }.to change { Issue.count }.by(1)
  end

  it 'creates an event' do
    expect { response }.to change { Event.count }.by(1)
  end

  context 'when there is already an issue with the github_id in the params' do
    let!(:issue) { create(:issue) }
    let(:issue_id) { issue.github_id }

    it 'does not create an issue' do
      expect { response }.to change { Issue.count }.by(0)
    end

    it 'associates the issue that already exists to the new event' do
      response

      expect(Event.last.issue_id).to eq(issue.id)
    end
  end
end
