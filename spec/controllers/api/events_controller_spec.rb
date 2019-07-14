require 'rails_helper'

RSpec.describe Api::EventsController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  describe 'GET index' do
    let!(:issue) { create(:issue) }
    let!(:other_issues) { create_list(:issue, 5) }
    let!(:events) { create_list(:event, 3, issue: issue) }
    let(:issue_id) { issue.github_id }

    before do
      get :index, params: { issue_id: issue_id }
    end

    it 'filters by issue github_id' do
      response_issue_id = json[:data].map { |resource| resource[:relationships][:issue][:data][:id].to_i }.uniq

      expect(response_issue_id).to eq([issue.id])
    end
  end
end
