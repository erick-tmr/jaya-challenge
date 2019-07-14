module Api
  class IssuesController < ApplicationController
    def index
      render_json_response(
        resources: issues,
        serializer: IssueSerializer
      )
    end

    def show
      render_json_response(
        resources: requested_issue,
        serializer: IssueSerializer
      )
    end

    private

    def issues
      @issues ||= Issue.all
    end

    def github_id
      params[:id]
    end

    def requested_issue
      issue = Issue.find_by(github_id: github_id)

      return [] if issue.nil?

      issue
    end
  end
end
