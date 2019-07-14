module Api
  class EventsController < ApplicationController
    def index
      render_json_response(
        resources: events,
        serializer: EventSerializer
      )
    end

    private

    def events
      return [] if requested_issue.nil?

      @events ||= requested_issue.events
    end

    def issue_github_id
      params[:issue_id]
    end

    def requested_issue
      Issue.find_by(github_id: issue_github_id)
    end
  end
end
